package com.school.mis.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "report_master")
public class ReportMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "report_id")
    private Long reportId;

    @Column(name = "report_name", nullable = false)
    private String reportName;

    @Column(name = "report_description")
    private String reportDescription;

    @Column(name = "report_query", nullable = false)
    private String reportQuery;

    @Column(name = "active_flag")
    private Boolean activeFlag = true;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    public ReportMaster() {}

    public Long getReportId() { return reportId; }
    public void setReportId(Long reportId) { this.reportId = reportId; }

    public String getReportName() { return reportName; }
    public void setReportName(String reportName) { this.reportName = reportName; }

    public String getReportDescription() { return reportDescription; }
    public void setReportDescription(String reportDescription) { this.reportDescription = reportDescription; }

    public String getReportQuery() { return reportQuery; }
    public void setReportQuery(String reportQuery) { this.reportQuery = reportQuery; }

    public Boolean getActiveFlag() { return activeFlag; }
    public void setActiveFlag(Boolean activeFlag) { this.activeFlag = activeFlag; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
