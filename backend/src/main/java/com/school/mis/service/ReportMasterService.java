package com.school.mis.service;

import com.school.mis.entity.Department;
import com.school.mis.entity.ReportMaster;
import com.school.mis.entity.ReportParameter;
import com.school.mis.repository.DepartmentRepository;
import com.school.mis.repository.ReportMasterRepository;
import com.school.mis.repository.ReportParameterRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class ReportMasterService {

    private final ReportMasterRepository reportMasterRepository;
    private final ReportParameterRepository reportParameterRepository;
    private final DepartmentRepository departmentRepository;
    private final JdbcTemplate jdbcTemplate;

    public ReportMasterService(ReportMasterRepository reportMasterRepository,
                               ReportParameterRepository reportParameterRepository,
                               DepartmentRepository departmentRepository,
                               JdbcTemplate jdbcTemplate) {
        this.reportMasterRepository = reportMasterRepository;
        this.reportParameterRepository = reportParameterRepository;
        this.departmentRepository = departmentRepository;
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<ReportMaster> getActiveReports() {
        return reportMasterRepository.findByActiveFlagTrue();
    }

    public List<ReportParameter> getReportParameters(Long reportId) {
        List<ReportParameter> parameters = reportParameterRepository.findByReportIdOrderByDisplayOrderAsc(reportId);
        for (ReportParameter param : parameters) {
            if ("DROPDOWN".equalsIgnoreCase(param.getParameterType()) && param.getDropdownQuery() != null && !param.getDropdownQuery().trim().isEmpty()) {
                try {
                    List<Map<String, Object>> options = jdbcTemplate.queryForList(param.getDropdownQuery());
                    param.setOptions(options);
                } catch (Exception e) {
                    // Log or ignore if dropdown query fails
                }
            }
        }
        return parameters;
    }

    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }
}
