package com.school.mis.repository;

import com.school.mis.entity.ReportParameter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReportParameterRepository extends JpaRepository<ReportParameter, Long> {
    List<ReportParameter> findByReportIdOrderByDisplayOrderAsc(Long reportId);
}
