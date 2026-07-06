import axios from 'axios';

const API_BASE = 'http://localhost:8081/api/reports';

export const getReports = async () => {
    const res = await axios.get(API_BASE);
    return res.data;
};

export const getParameters = async (reportId) => {
    const res = await axios.get(`${API_BASE}/${reportId}/parameters`);
    return res.data;
};

export const getDepartments = async () => {
    const res = await axios.get(`${API_BASE}/departments`);
    return res.data;
};

export const executeReport = async (reportId, filters) => {
    const res = await axios.post(`${API_BASE}/${reportId}/execute`, filters);
    return res.data;
};

export const downloadExcel = async (reportId, filters) => {
    const res = await axios.post(`${API_BASE}/${reportId}/export/excel`, filters, {
        responseType: 'blob'
    });
    const url = window.URL.createObjectURL(new Blob([res.data]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'college_mis_report.xlsx');
    document.body.appendChild(link);
    link.click();
    link.remove();
};

export const downloadPdf = async (reportId, filters) => {
    const res = await axios.post(`${API_BASE}/${reportId}/export/pdf`, filters, {
        responseType: 'blob'
    });
    const url = window.URL.createObjectURL(new Blob([res.data], { type: 'application/pdf' }));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'college_mis_report.pdf');
    document.body.appendChild(link);
    link.click();
    link.remove();
};
