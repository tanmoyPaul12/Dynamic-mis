package com.school.mis.controller;

import com.school.mis.dto.ReportExecutionResponse;
import com.school.mis.dto.ReportFilterRequest;
import com.school.mis.entity.Department;
import com.school.mis.entity.ReportMaster;
import com.school.mis.entity.ReportParameter;
import com.school.mis.service.ReportExecutionService;
import com.school.mis.service.ReportExportService;
import com.school.mis.service.ReportMasterService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reports")
public class ReportController {

    private final ReportMasterService masterService;
    private final ReportExecutionService executionService;
    private final ReportExportService exportService;

    public ReportController(ReportMasterService masterService,
                            ReportExecutionService executionService,
                            ReportExportService exportService) {
        this.masterService = masterService;
        this.executionService = executionService;
        this.exportService = exportService;
    }

    @GetMapping
    public List<ReportMaster> getReports() {
        return masterService.getActiveReports();
    }

    @GetMapping("/{id}/parameters")
    public List<ReportParameter> getParameters(@PathVariable Long id) {
        return masterService.getReportParameters(id);
    }

    @GetMapping("/departments")
    public List<Department> getDepartments() {
        return masterService.getAllDepartments();
    }

    @PostMapping("/{id}/execute")
    public ReportExecutionResponse executeReport(@PathVariable Long id, @RequestBody(required = false) ReportFilterRequest filters) {
        if (filters == null) filters = new ReportFilterRequest();
        return executionService.executeReport(id, filters);
    }

    @PostMapping("/{id}/export/excel")
    public ResponseEntity<byte[]> exportExcel(@PathVariable Long id, @RequestBody(required = false) ReportFilterRequest filters) throws Exception {
        if (filters == null) filters = new ReportFilterRequest();
        byte[] excel = exportService.exportToExcel(id, filters);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=school_mis_report.xlsx")
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(excel);
    }

    @PostMapping("/{id}/export/pdf")
    public ResponseEntity<byte[]> exportPdf(@PathVariable Long id, @RequestBody(required = false) ReportFilterRequest filters) throws Exception {
        if (filters == null) filters = new ReportFilterRequest();
        byte[] pdf = exportService.exportToPdf(id, filters);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=school_mis_report.pdf")
                .contentType(MediaType.APPLICATION_PDF)
                .body(pdf);
    }
}
