import React, { useState, useEffect } from 'react';
import { getReports, getParameters, executeReport, downloadExcel, downloadPdf } from './services/api';
import { Download, Search, FileText, Filter, Layers, CheckCircle } from 'lucide-react';

function App() {
  const [reports, setReports] = useState([]);
  const [selectedReportId, setSelectedReportId] = useState('');
  const [parameters, setParameters] = useState([]);
  
  // Dynamic filter state
  const [filterValues, setFilterValues] = useState({});
  const [selectedColumns, setSelectedColumns] = useState([]);

  // Results state
  const [reportData, setReportData] = useState([]);
  const [executionTime, setExecutionTime] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    loadInitialData();
  }, []);

  useEffect(() => {
    if (selectedReportId) {
      setFilterValues({});
      setSelectedColumns([]);
      loadParameters(selectedReportId);
      handleSearch(selectedReportId, {}, []);
    }
  }, [selectedReportId]);

  const loadInitialData = async () => {
    try {
      const reps = await getReports();
      setReports(reps);
    } catch (err) {
      console.error("Failed to load initial data", err);
    }
  };

  const loadParameters = async (repId) => {
    try {
      const params = await getParameters(repId);
      setParameters(params || []);
    } catch (err) {
      console.error("Failed to load parameters", err);
      setParameters([]);
    }
  };

  const handleFilterChange = (paramName, value) => {
    setFilterValues(prev => ({
      ...prev,
      [paramName]: value
    }));
  };

  const handleSearch = async (repId = selectedReportId, currentFilters = filterValues, currentCols = selectedColumns) => {
    if (!repId) return;
    setLoading(true);
    try {
      const payload = {
        filters: currentFilters,
        selectedColumns: currentCols.length > 0 ? currentCols : null
      };
      const res = await executeReport(repId, payload);
      const data = res.data || [];
      setReportData(data);
      setExecutionTime(res.executionDurationMs);
      if (currentCols.length === 0 && data.length > 0) {
        setSelectedColumns(Object.keys(data[0]));
      }
    } catch (err) {
      console.error("Report execution failed", err);
      setReportData([]);
    } finally {
      setLoading(false);
    }
  };

  const handleExcel = () => {
    if (selectedReportId) {
      downloadExcel(selectedReportId, {
        filters: filterValues,
        selectedColumns: selectedColumns.length > 0 ? selectedColumns : null
      });
    }
  };

  const handlePdf = () => {
    if (selectedReportId) {
      downloadPdf(selectedReportId, {
        filters: filterValues,
        selectedColumns: selectedColumns.length > 0 ? selectedColumns : null
      });
    }
  };

  const displayColumns = selectedColumns.length > 0 && reportData.length > 0
    ? selectedColumns
    : (reportData.length > 0 ? Object.keys(reportData[0]) : []);

  return (
    <div className="app-container">
      <header className="header">
        <div className="header-content">
          <div className="title-wrapper">
            <h1>Dynamic Management Reporting Service</h1>
          </div>
        </div>
      </header>

      <div className="card filter-card">
        <div className="form-title">
          <Filter size={18} className="icon-teal" /> 
          <span>Select Report & Configure Filters</span>
        </div>
        
        <div className="filter-grid">
          <div className="form-group">
            <label>Report Type</label>
            <select 
              className="form-control select-primary"
              value={selectedReportId} 
              onChange={(e) => setSelectedReportId(e.target.value)}
            >
              <option value="">-- Select a Report --</option>
              {reports.map(r => (
                <option key={r.reportId} value={r.reportId}>{r.reportName}</option>
              ))}
            </select>
          </div>

          {/* DYNAMIC PARAMETER RENDERING */}
          {parameters.map((param) => (
            <div key={param.parameterId} className="form-group animate-box">
              <label>{param.parameterLabel}</label>
              {param.parameterType === 'DROPDOWN' ? (
                <select 
                  className="form-control"
                  value={filterValues[param.parameterName] || ''} 
                  onChange={(e) => handleFilterChange(param.parameterName, e.target.value)}
                >
                  <option value="">All {param.parameterLabel}s</option>
                  {param.options?.map((opt, idx) => (
                    <option key={opt.value || idx} value={opt.value}>{opt.label}</option>
                  ))}
                </select>
              ) : (
                <input 
                  type={param.parameterType === 'DATE' ? 'date' : 'text'}
                  className="form-control"
                  placeholder={`Enter ${param.parameterLabel}...`}
                  value={filterValues[param.parameterName] || ''}
                  onChange={(e) => handleFilterChange(param.parameterName, e.target.value)}
                />
              )}
            </div>
          ))}
        </div>

        {/* DYNAMIC COLUMN SELECTION TOGGLE */}
        {reportData.length > 0 && (
          <div className="column-toggle-section" style={{ marginTop: '1.5rem', padding: '1rem', background: 'rgba(255,255,255,0.03)', borderRadius: '8px', border: '1px solid rgba(255,255,255,0.08)' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '10px', fontWeight: 'bold', color: '#64ffda', fontSize: '0.95rem' }}>
              <Layers size={16} />
              <span>Select Columns to Display & Export</span>
            </div>
            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '14px' }}>
              {Object.keys(reportData[0]).map(col => (
                <label key={col} style={{ display: 'flex', alignItems: 'center', gap: '6px', cursor: 'pointer', fontSize: '0.88rem', color: '#e0e0e0', userSelect: 'none' }}>
                  <input 
                    type="checkbox" 
                    checked={selectedColumns.includes(col)}
                    onChange={(e) => {
                      if (e.target.checked) {
                        setSelectedColumns(prev => [...prev, col]);
                      } else {
                        if (selectedColumns.length > 1) {
                          setSelectedColumns(prev => prev.filter(c => c !== col));
                        }
                      }
                    }}
                    style={{ accentColor: '#64ffda', width: '15px', height: '15px', cursor: 'pointer' }}
                  />
                  <span>{col}</span>
                </label>
              ))}
            </div>
          </div>
        )}

        <div className="action-bar">
          <button className="btn btn-primary" onClick={() => handleSearch()}>
            <Search size={16} /> Search Records
          </button>
          <button className="btn btn-success" onClick={handleExcel} disabled={reportData.length === 0}>
            <Download size={16} /> Export Excel (.xlsx)
          </button>
          <button className="btn btn-danger" onClick={handlePdf} disabled={reportData.length === 0}>
            <FileText size={16} /> Export PDF
          </button>
        </div>
      </div>

      <div className="card results-card">
        <div className="stats-bar">
          <div className="results-info">
            <CheckCircle size={18} className="icon-success" />
            <h3>Report Results ({reportData.length} Records Found)</h3>
          </div>
          {executionTime !== null && <span className="time-badge">Execution time: {executionTime} ms</span>}
        </div>

        {loading ? (
          <div className="loading-state">
            <div className="spinner"></div>
            <p>Executing query & formatting records...</p>
          </div>
        ) : reportData.length === 0 ? (
          <div className="empty-state">
            <p>No student records found matching the selected report or filter criteria.</p>
          </div>
        ) : (
          <div className="table-responsive">
            <table>
              <thead>
                <tr>
                  {displayColumns.map(col => (
                    <th key={col}>{col}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {reportData.map((row, idx) => (
                  <tr key={idx}>
                    {displayColumns.map((col, cIdx) => {
                      const val = row[col];
                      const strVal = val !== null && val !== undefined ? String(val) : '-';
                      const numScore = parseFloat(strVal);
                      const isAlertCell = (typeof val === 'number' && col.includes('Attendance') && val < 75) ||
                                          (col.includes('Score') && !isNaN(numScore) && numScore < 40) ||
                                          strVal === 'Supplementary Required';
                      return (
                        <td key={cIdx} className={isAlertCell ? 'cell-alert' : ''}>
                          {strVal}
                        </td>
                      );
                    })}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}

export default App;
