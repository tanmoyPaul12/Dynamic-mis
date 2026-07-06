package com.school.mis.service;

import com.school.mis.dto.ReportExecutionResponse;
import com.school.mis.dto.ReportFilterRequest;
import com.school.mis.entity.ReportExecutionLog;
import com.school.mis.entity.ReportMaster;
import com.school.mis.entity.ReportParameter;
import com.school.mis.repository.ReportExecutionLogRepository;
import com.school.mis.repository.ReportMasterRepository;
import com.school.mis.repository.ReportParameterRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class ReportExecutionService {

    private final JdbcTemplate jdbcTemplate;
    private final ReportMasterRepository reportMasterRepository;
    private final ReportExecutionLogRepository logRepository;
    private final ReportParameterRepository reportParameterRepository;

    public ReportExecutionService(JdbcTemplate jdbcTemplate,
                                  ReportMasterRepository reportMasterRepository,
                                  ReportExecutionLogRepository logRepository,
                                  ReportParameterRepository reportParameterRepository) {
        this.jdbcTemplate = jdbcTemplate;
        this.reportMasterRepository = reportMasterRepository;
        this.logRepository = logRepository;
        this.reportParameterRepository = reportParameterRepository;
    }

    public List<Map<String, Object>> executeQuery(ReportMaster report, ReportFilterRequest filters) {
        String originalQuery = report.getReportQuery();
        String selectPart = originalQuery;
        String groupByPart = "";

        int groupByIdx = originalQuery.toUpperCase().indexOf(" GROUP BY ");
        if (groupByIdx != -1) {
            selectPart = originalQuery.substring(0, groupByIdx);
            groupByPart = originalQuery.substring(groupByIdx);
        }

        StringBuilder sql = new StringBuilder(selectPart);
        if (!selectPart.toLowerCase().contains(" where ")) {
            sql.append(" WHERE 1=1 ");
        }

        List<Object> params = new ArrayList<>();
        List<ReportParameter> allowedParams = reportParameterRepository.findByReportIdOrderByDisplayOrderAsc(report.getReportId());

        if (filters != null) {
            Map<String, Object> dynamicMap = filters.getFilters();

            for (ReportParameter param : allowedParams) {
                String key = param.getParameterName();
                Object val = dynamicMap != null ? dynamicMap.get(key) : null;

                // Fallback to legacy DTO getters if dynamic map didn't have it
                if (val == null || String.valueOf(val).trim().isEmpty()) {
                    if ("department_id".equalsIgnoreCase(key) && filters.getDepartmentId() != null) val = filters.getDepartmentId();
                    else if ("semester".equalsIgnoreCase(key) && filters.getSemester() != null) val = filters.getSemester();
                    else if ("student_name".equalsIgnoreCase(key) && filters.getStudentName() != null) val = filters.getStudentName();
                    else if ("roll_no".equalsIgnoreCase(key) && filters.getRollNo() != null) val = filters.getRollNo();
                    else if ("exam_type".equalsIgnoreCase(key) && filters.getExamTerm() != null) val = filters.getExamTerm();
                }

                if (val != null && !String.valueOf(val).trim().isEmpty() && !String.valueOf(val).equalsIgnoreCase("ALL")) {
                    String strVal = String.valueOf(val).trim();
                    if ("TEXT".equalsIgnoreCase(param.getParameterType())) {
                        sql.append(" AND LOWER(s.").append(key).append(") LIKE LOWER(?)");
                        params.add("%" + strVal + "%");
                    } else if ("DATE".equalsIgnoreCase(param.getParameterType())) {
                        sql.append(" AND ").append(key).append(" = CAST(? AS DATE)");
                        params.add(strVal);
                    } else {
                        // DROPDOWN / NUMBER
                        if ("exam_type".equalsIgnoreCase(key) || "session_year".equalsIgnoreCase(key)) {
                            sql.append(" AND m.").append(key).append(" = ?");
                            params.add(strVal);
                        } else if ("department_id".equalsIgnoreCase(key)) {
                            sql.append(" AND d.department_id = ?");
                            params.add(Long.parseLong(strVal));
                        } else if ("semester".equalsIgnoreCase(key)) {
                            sql.append(" AND s.semester = ?");
                            params.add(Integer.parseInt(strVal));
                        } else {
                            sql.append(" AND s.").append(key).append(" = ?");
                            params.add(val);
                        }
                    }
                }
            }
        }

        sql.append(" ").append(groupByPart);
        if (selectPart.toLowerCase().contains("roll_no")) {
            sql.append(" ORDER BY s.roll_no ASC");
        } else if (report.getReportId() == 1L) {
            sql.append(" ORDER BY d.department_id ASC");
        }

        return jdbcTemplate.queryForList(sql.toString(), params.toArray());
    }

    public ReportExecutionResponse executeReport(Long reportId, ReportFilterRequest filters) {
        long startTime = System.currentTimeMillis();

        ReportMaster report = reportMasterRepository.findById(reportId)
                .orElseThrow(() -> new RuntimeException("Report not found with ID: " + reportId));

        List<Map<String, Object>> result = executeQuery(report, filters);

        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;

        ReportExecutionLog log = new ReportExecutionLog();
        log.setReportId(reportId);
        log.setExecutedBy("USER");
        log.setOutputFormat("JSON");
        log.setExecutionStatus("SUCCESS");
        log.setExecutionDurationMs(duration);
        logRepository.save(log);

        return new ReportExecutionResponse(report.getReportName(), duration, result.size(), result);
    }
}
