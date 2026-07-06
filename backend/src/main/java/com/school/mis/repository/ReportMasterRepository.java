package com.school.mis.repository;

import com.school.mis.entity.ReportMaster;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ReportMasterRepository extends JpaRepository<ReportMaster, Long> {
    List<ReportMaster> findByActiveFlagTrue();
}
