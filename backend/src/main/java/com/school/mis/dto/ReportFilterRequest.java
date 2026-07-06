package com.school.mis.dto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReportFilterRequest {
    private Long departmentId;
    private Integer semester; // Class 11 or 12
    private String studentName;
    private String rollNo;
    private String examTerm;
    private String fromDate;
    private String toDate;

    private Map<String, Object> filters = new HashMap<>();
    private List<String> selectedColumns;

    public ReportFilterRequest() {}

    public Map<String, Object> getFilters() { return filters; }
    public void setFilters(Map<String, Object> filters) { this.filters = filters; }

    public List<String> getSelectedColumns() { return selectedColumns; }
    public void setSelectedColumns(List<String> selectedColumns) { this.selectedColumns = selectedColumns; }

    public String getExamTerm() { return examTerm; }
    public void setExamTerm(String examTerm) { this.examTerm = examTerm; }

    public Long getDepartmentId() { return departmentId; }
    public void setDepartmentId(Long departmentId) { this.departmentId = departmentId; }

    public Integer getSemester() { return semester; }
    public void setSemester(Integer semester) { this.semester = semester; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getRollNo() { return rollNo; }
    public void setRollNo(String rollNo) { this.rollNo = rollNo; }

    public String getFromDate() { return fromDate; }
    public void setFromDate(String fromDate) { this.fromDate = fromDate; }

    public String getToDate() { return toDate; }
    public void setToDate(String toDate) { this.toDate = toDate; }
}
