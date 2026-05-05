<%-- 
    Document   : conexion
    Created on : 5/03/2026, 03:57:59 PM
    Author     : abrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="java.sql.*" %>

<%
       Connection conexion=null;
       PreparedStatement st=null;
       ResultSet rs=null;
    
       Class.forName("com.mysql.jdbc.Driver");
       conexion=DriverManager.getConnection("jdbc:mysql://localhost:3306/bd_preexamen","root","");

%>