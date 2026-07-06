package com.school.mis.service;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.school.mis.dto.ReportFilterRequest;
import com.school.mis.entity.ReportMaster;
import com.school.mis.repository.ReportMasterRepository;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class ReportExportService {

    private final ReportExecutionService executionService;
    private final ReportMasterRepository reportMasterRepository;

    public ReportExportService(ReportExecutionService executionService, ReportMasterRepository reportMasterRepository) {
        this.executionService = executionService;
        this.reportMasterRepository = reportMasterRepository;
    }

    public byte[] exportToExcel(Long reportId, ReportFilterRequest filters) throws Exception {
        ReportMaster report = reportMasterRepository.findById(reportId)
                .orElseThrow(() -> new RuntimeException("Report not found"));
        List<Map<String, Object>> data = executionService.executeQuery(report, filters);

        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet("College MIS Report");

            if (!data.isEmpty()) {
                // Header Row
                Row headerRow = sheet.createRow(0);
                List<String> headers;
                if (filters != null && filters.getSelectedColumns() != null && !filters.getSelectedColumns().isEmpty()) {
                    headers = filters.getSelectedColumns();
                } else {
                    headers = new ArrayList<>(data.get(0).keySet());
                }

                int colIdx = 0;
                CellStyle headerStyle = workbook.createCellStyle();
                org.apache.poi.ss.usermodel.Font font = workbook.createFont();
                font.setBold(true);
                headerStyle.setFont(font);

                for (String header : headers) {
                    Cell cell = headerRow.createCell(colIdx++);
                    cell.setCellValue(header);
                    cell.setCellStyle(headerStyle);
                }

                // Data Rows
                int rowIdx = 1;
                for (Map<String, Object> rowMap : data) {
                    Row row = sheet.createRow(rowIdx++);
                    colIdx = 0;
                    for (String header : headers) {
                        Cell cell = row.createCell(colIdx++);
                        Object val = rowMap.get(header);
                        cell.setCellValue(val != null ? val.toString() : "");
                    }
                }
            }

            workbook.write(out);
            return out.toByteArray();
        }
    }

    public byte[] exportToPdf(Long reportId, ReportFilterRequest filters) throws Exception {
        ReportMaster report = reportMasterRepository.findById(reportId)
                .orElseThrow(() -> new RuntimeException("Report not found"));
        List<Map<String, Object>> data = executionService.executeQuery(report, filters);

        Document document = new Document(PageSize.A4.rotate());
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, out);
        document.open();

        com.lowagie.text.Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
        Paragraph title = new Paragraph("College Engineering & Degree MIS - " + report.getReportName(), titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        if (!data.isEmpty()) {
            List<String> headers;
            if (filters != null && filters.getSelectedColumns() != null && !filters.getSelectedColumns().isEmpty()) {
                headers = filters.getSelectedColumns();
            } else {
                headers = new ArrayList<>(data.get(0).keySet());
            }

            PdfPTable table = new PdfPTable(headers.size());
            table.setWidthPercentage(100);

            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11)));
                cell.setBackgroundColor(new java.awt.Color(230, 230, 250));
                cell.setPadding(6);
                table.addCell(cell);
            }

            for (Map<String, Object> rowMap : data) {
                for (String header : headers) {
                    Object val = rowMap.get(header);
                    PdfPCell cell = new PdfPCell(new Phrase(val != null ? val.toString() : "", FontFactory.getFont(FontFactory.HELVETICA, 10)));
                    cell.setPadding(5);
                    table.addCell(cell);
                }
            }
            document.add(table);
        } else {
            document.add(new Paragraph("No records found matching criteria."));
        }

        document.close();
        return out.toByteArray();
    }
}
