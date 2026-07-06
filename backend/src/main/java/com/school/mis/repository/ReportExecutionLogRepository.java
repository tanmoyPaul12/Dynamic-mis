package com.school.mis.repository;

import com.school.mis.entity.ReportExecutionLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReportExecutionLogRepository extends JpaRepository<ReportExecutionLog, Long> {
}
