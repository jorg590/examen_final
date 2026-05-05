<%-- 
    Document   : principal
    Created on : 5/05/2026, 09:38:04 AM
    Author     : abrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inicio | Plataforma ASI</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background-color: #f8fafc; margin: 0; padding: 0; }
        .navbar { background-color: #0f172a; color: white; padding: 20px; text-align: center; border-bottom: 4px solid #2563eb; }
        .hero { text-align: center; padding: 60px 20px; background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); color: white; }
        .container { max-width: 1200px; margin: -40px auto 40px auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 25px; padding: 20px; }
        .card { background: white; padding: 35px; border-radius: 16px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); text-align: center; border: 1px solid #e2e8f0; transition: transform 0.3s; }
        .card:hover { transform: translateY(-10px); box-shadow: 0 15px 35px rgba(37, 99, 235, 0.1); }
        .card h3 { color: #1e293b; font-size: 1.4rem; margin-bottom: 15px; }
        .card p { color: #64748b; font-size: 0.95rem; line-height: 1.6; margin-bottom: 25px; min-height: 80px; }
        .btn-nav { display: inline-block; background-color: #2563eb; color: white; text-decoration: none; padding: 12px 30px; border-radius: 8px; font-weight: bold; }
        .btn-nav:hover { background-color: #1d4ed8; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>SISTEMA INTEGRAL DE SEGURIDAD (ASI)</h2>
    </div>
    <div class="hero">
        <h1>Centro de Mando Proactivo</h1>
        <p>Administración avanzada de activos digitales y detección temprana de amenazas.</p>
    </div>
    <div class="container">
        <div class="card">
            <div style="font-size: 45px;">🛡️</div>
            <h3>Vulnerabilidades</h3>
            <p>Registro y gestión de brechas de seguridad y configuraciones técnicas con cifrado SHA-256.</p>
            <a href="vulnerabilidades.jsp" class="btn-nav">Gestionar</a>
        </div>
        <div class="card">
            <div style="font-size: 45px;">📝</div>
            <h3>Evaluación</h3>
            <p>Cuestionario educativo interactivo sobre políticas de contraseñas y biometría avanzada.</p>
            <a href="cuestionario.jsp" class="btn-nav">Iniciar Test</a>
        </div>
        <div class="card">
            <div style="font-size: 45px;">🦇</div>
            <h3>Clave Murciélago</h3>
            <p>Codificador por sustitución numérica para mensajes confidenciales y entrenamiento criptográfico.</p>
            <a href="contraseña.jsp" class="btn-nav">Codificar</a>
        </div>
        <div class="card">
            <div style="font-size: 45px;">🚨</div>
            <h3>Bitácora WAF</h3>
            <p>Monitoreo en tiempo real de ataques bloqueados por el Firewall de Aplicación Web.</p>
            <a href="alertas.jsp" class="btn-nav">Ver Alertas</a>
        </div>
    </div>
</body>
</html>