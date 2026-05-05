<%-- 
    Document   : vulnerabilidades
    Created on : 5/05/2026, 09:50:53 AM
    Author     : abrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>

<%-- MÉTODOS DE SEGURIDAD --%>
<%!
    public String aplicarSHA256(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                String h = Integer.toHexString(0xff & b);
                if(h.length() == 1) hex.append('0');
                hex.append(h);
            }
            return hex.toString();
        } catch (Exception e) { return "Error"; }
    }

    public boolean esAtaque(String texto) {
        if (texto == null) return false;
        String t = texto.toUpperCase();
        return t.contains("SELECT") || t.contains("--") || t.contains("<SCRIPT>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registro de Vulnerabilidades</title>
    <style>
        body { font-family: sans-serif; background: #f8fafc; padding: 30px; }
        .container { max-width: 900px; margin: auto; background: white; padding: 25px; border-radius: 10px; border: 1px solid #ddd; }
        .form-row { margin-bottom: 15px; }
        .form-row label { display: block; font-weight: bold; margin-bottom: 5px; }
        .input-style { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
        .btn-submit { background: #16a34a; color: white; border: none; padding: 12px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; }
        .btn-back { display: inline-block; margin-bottom: 20px; color: #2563eb; text-decoration: none; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 30px; }
        th { background: #1e293b; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border: 1px solid #eee; }
        .hash { font-family: monospace; font-size: 0.75em; color: #666; word-break: break-all; }
    </style>
</head>
<body>

    <div class="container">
        <a href="principal.jsp" class="btn-back">← Volver al Inicio</a>
        <h2>Gestión de Vulnerabilidades y Tips</h2>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String cat = request.getParameter("categoria");
                String tit = request.getParameter("titulo");
                String cont = request.getParameter("contenido");

                if (esAtaque(tit) || esAtaque(cont)) {
                    out.println("<div style='color:red; padding:10px;'>¡WAF BLOCK! Intento de ataque detectado.</div>");
                } else {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/edu_ia_db", "root", "");
                        
                        String cifrado = aplicarSHA256(cont);
                        
                        PreparedStatement ps = con.prepareStatement("INSERT INTO tips (categoria, titulo, contenido) VALUES (?,?,?)");
                        ps.setString(1, cat);
                        ps.setString(2, tit);
                        ps.setString(3, cifrado);
                        ps.executeUpdate();
                        con.close();
                        out.println("<div style='color:green; padding:10px;'>✓ Registrado con éxito.</div>");
                    } catch (Exception e) { out.println("Error: " + e.getMessage()); }
                }
            }
        %>

        <form method="POST">
            <div class="form-row">
                <label>Categoría:</label>
                <select name="categoria" class="input-style">
                    <option value="Tip Técnico">Tip Técnico</option>
                    <option value="Legislación">Legislación</option>
                    <option value="Consejo">Consejo</option>
                </select>
            </div>
            <div class="form-row">
                <label>Título:</label>
                <input type="text" name="titulo" class="input-style" required>
            </div>
            <div class="form-row">
                <label>Contenido / Vulnerabilidad:</label>
                <textarea name="contenido" class="input-style" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn-submit">Guardar Registro Seguro</button>
        </form>

        <table>
            <thead>
                <tr><th>ID</th><th>Categoría</th><th>Título</th><th>Contenido (Cifrado)</th></tr>
            </thead>
            <tbody>
                <%
                    try {
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/edu_ia_db", "root", "");
                        ResultSet rs = con.createStatement().executeQuery("SELECT * FROM tips ORDER BY id DESC");
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("categoria") %></td>
                    <td><b><%= rs.getString("titulo") %></b></td>
                    <td class="hash"><%= rs.getString("contenido") %></td>
                </tr>
                <%      } con.close();
                    } catch (Exception e) { out.println("<tr><td colspan='4'>Error al cargar datos</td></tr>"); }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>