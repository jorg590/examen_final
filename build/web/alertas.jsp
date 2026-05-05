<%-- 
    Document   : alertas
    Created on : 5/05/2026, 10:31:43 AM
    Author     : abrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bitácora de Seguridad | Auditoría</title>
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f1f5f9; margin: 0; padding: 40px; color: #1e293b; }
        .header-dashboard { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .btn-back { text-decoration: none; background: #fff; border: 1px solid #e2e8f0; padding: 10px 20px; border-radius: 8px; color: #64748b; font-weight: 600; }
        
        /* Tarjetas de Resumen */
        .summary-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 40px; }
        .summary-card { background: white; padding: 25px; border-radius: 12px; border: 1px solid #e2e8f0; display: flex; flex-direction: column; }
        .summary-card span { font-size: 0.85rem; color: #64748b; text-transform: uppercase; font-weight: bold; }
        .summary-card b { font-size: 2rem; color: #0f172a; margin-top: 5px; }

        /* Estilo de la Tabla Consultoría */
        .table-container { background: white; border-radius: 12px; border: 1px solid #e2e8f0; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.02); }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: #f8fafc; padding: 18px; font-size: 0.85rem; color: #64748b; border-bottom: 2px solid #f1f5f9; text-transform: uppercase; }
        td { padding: 18px; border-bottom: 1px solid #f1f5f9; font-size: 0.95rem; }
        
        /* Badges de Amenaza */
        .badge { padding: 5px 12px; border-radius: 50px; font-size: 0.75rem; font-weight: bold; }
        .badge-critical { background: #fee2e2; color: #b91c1c; }
        .badge-high { background: #ffedd5; color: #9a3412; }
        .badge-medium { background: #fef9c3; color: #854d0e; }
        
        .payload-box { font-family: monospace; color: #475569; background: #f8fafc; padding: 5px 10px; border-radius: 4px; border: 1px solid #e2e8f0; }
    </style>
</head>
<body>
    <div class="header-dashboard">
        <div>
            <h1 style="margin:0;">Bitácora de Intrusiones</h1>
            <p style="color:#64748b; margin:5px 0 0 0;">Análisis detallado de incidentes bloqueados por el WAF.</p>
        </div>
        <a href="principal.jsp" class="btn-back">Volver al Inicio</a>
    </div>

    <div class="summary-grid">
        <div class="summary-card"><span>Ataques Totales</span><b>24</b></div>
        <div class="summary-card"><span>Amenazas Críticas</span><b style="color:#dc2626;">08</b></div>
        <div class="summary-card"><span>Tiempo de Respuesta</span><b>0 ms</b></div>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tipo de Ataque</th>
                    <th>Descripción del Intento (Payload)</th>
                    <th>Severidad</th>
                    <th>Marca de Tiempo</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/edu_ia_db", "root", "");
                        ResultSet rs = con.createStatement().executeQuery("SELECT * FROM audit_logs ORDER BY id DESC");
                        while (rs.next()) {
                            String tipo = rs.getString("tipo_ataque");
                            String badgeClass = "badge-medium";
                            if(tipo.contains("SQL")) badgeClass = "badge-critical";
                            if(tipo.contains("XSS")) badgeClass = "badge-high";
                %>
                <tr>
                    <td>#<%= rs.getInt("id") %></td>
                    <td style="font-weight:bold;"><%= tipo %></td>
                    <td><span class="payload-box"><%= rs.getString("payload_detectado") %></span></td>
                    <td><span class="badge <%= badgeClass %>">
                        <%= badgeClass.equals("badge-critical") ? "CRÍTICA" : (badgeClass.equals("badge-high") ? "ALTA" : "MEDIA") %>
                    </span></td>
                    <td style="color:#64748b;"><%= rs.getString("fecha") %></td>
                </tr>
                <%      } con.close();
                    } catch (Exception e) { out.println("<tr><td colspan='5'>Conecte la DB para visualizar logs reales.</td></tr>"); }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
