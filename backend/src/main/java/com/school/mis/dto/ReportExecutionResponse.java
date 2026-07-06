package com.school.mis.dto;

import java.util.List;
import java.util.Map;

public class ReportExecutionResponse {
    private String reportName;
    private Long executionDurationMs;
    private Integer totalRecords;
    private List<Map<String, Object>> data;

    public ReportExecutionResponse() {}

    public ReportExecutionResponse(String reportName, Long executionDurationMs, Integer totalRecords, List<Map<String, Object>> data) {
        this.reportName = reportName;
        this.executionDurationMs = executionDurationMs;
        this.totalRecords = totalRecords;
        this.data = data;
    }

    public String getReportName() { return reportName; }
    public void setReportName(String reportName) { this.reportName = reportName; }

    public Long getExecutionDurationMs() { return executionDurationMs; }
    public void setExecutionDurationMs(Long executionDurationMs) { this.executionDurationMs = executionDurationMs; }

    public Integer getTotalRecords() { return totalRecords; }
    public void setTotalRecords(Integer totalRecords) { this.totalRecords = totalRecords; }

    public List<Map<String, Object>> getData() { return data; }
    public void setData(List<Map<String, Object>> data) { this.data = data; }
}
