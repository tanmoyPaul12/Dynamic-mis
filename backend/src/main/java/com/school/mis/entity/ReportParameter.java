package com.school.mis.entity;

import jakarta.persistence.*;
import java.util.List;
import java.util.Map;

@Entity
@Table(name = "report_parameter")
public class ReportParameter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "parameter_id")
    private Long parameterId;

    @Column(name = "report_id", nullable = false)
    private Long reportId;

    @Column(name = "parameter_name", nullable = false)
    private String parameterName;

    @Column(name = "parameter_label", nullable = false)
    private String parameterLabel;

    @Column(name = "parameter_type", nullable = false)
    private String parameterType;

    @Column(name = "required_flag")
    private Boolean requiredFlag = false;

    @Column(name = "dropdown_query")
    private String dropdownQuery;

    @Column(name = "display_order")
    private Integer displayOrder;

    @Transient
    private List<Map<String, Object>> options;

    public ReportParameter() {}

    public Long getParameterId() { return parameterId; }
    public void setParameterId(Long parameterId) { this.parameterId = parameterId; }

    public Long getReportId() { return reportId; }
    public void setReportId(Long reportId) { this.reportId = reportId; }

    public String getParameterName() { return parameterName; }
    public void setParameterName(String parameterName) { this.parameterName = parameterName; }

    public String getParameterLabel() { return parameterLabel; }
    public void setParameterLabel(String parameterLabel) { this.parameterLabel = parameterLabel; }

    public String getParameterType() { return parameterType; }
    public void setParameterType(String parameterType) { this.parameterType = parameterType; }

    public Boolean getRequiredFlag() { return requiredFlag; }
    public void setRequiredFlag(Boolean requiredFlag) { this.requiredFlag = requiredFlag; }

    public String getDropdownQuery() { return dropdownQuery; }
    public void setDropdownQuery(String dropdownQuery) { this.dropdownQuery = dropdownQuery; }

    public Integer getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(Integer displayOrder) { this.displayOrder = displayOrder; }

    public List<Map<String, Object>> getOptions() { return options; }
    public void setOptions(List<Map<String, Object>> options) { this.options = options; }
}
