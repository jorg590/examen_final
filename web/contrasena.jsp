<%-- 
    Document   : contrasena
    Created on : 5/05/2026, 10:18:29 AM
    Author     : abrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cifrado Murciélago | ASI</title>
    <style>
        body { font-family: sans-serif; background: #f1f5f9; padding: 40px; color: #1e293b; }
        .container { max-width: 600px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
        .input-field { width: 100%; padding: 12px; margin: 15px 0; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; font-size: 1rem; }
        .btn-encode { background: #1e293b; color: white; border: none; padding: 12px 20px; border-radius: 6px; cursor: pointer; font-weight: bold; width: 100%; }
        .result-box { margin-top: 25px; padding: 20px; background: #f8fafc; border-left: 5px solid #1e293b; border-radius: 4px; }
        .btn-back { display: inline-block; margin-bottom: 20px; color: #2563eb; text-decoration: none; font-size: 0.9rem; }
    </style>
</head>
<body>

    <div class="container">
        <a href="principal.jsp" class="btn-back">← Volver al Menú</a>
        <h2>Cifrado Murciélago</h2>
      

        <form method="POST">
            <label>Ingrese su frase o palabra:</label>
            <input type="text" name="original" class="input-field" placeholder="Ej: Hola Mundo" required>
            <button type="submit" class="btn-encode">Codificar Mensaje</button>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String original = request.getParameter("original");
                String resultado = "";
                
                // Lógica de Cifrado Murciélago
                if (original != null) {
                    char[] caracteres = original.toUpperCase().toCharArray();
                    for (char c : caracteres) {
                        switch (c) {
                            case 'M': resultado += "0"; break;
                            case 'U': resultado += "1"; break;
                            case 'R': resultado += "2"; break;
                            case 'C': resultado += "3"; break;
                            case 'I': resultado += "4"; break;
                            case 'E': resultado += "5"; break;
                            case 'L': resultado += "6"; break;
                            case 'A': resultado += "7"; break;
                            case 'G': resultado += "8"; break;
                            case 'O': resultado += "9"; break;
                            default:  resultado += c;   break;
                        }
                    }
                }
        %>
            <div class="result-box">
                <p style="margin: 0; font-size: 0.8rem; color: #64748b;">MENSAJE CODIFICADO:</p>
                <h3 style="margin: 10px 0 0 0; letter-spacing: 2px; color: #1e293b;"><%= resultado %></h3>
            </div>
        <%
            }
        %>
    </div>

</body>
</html>