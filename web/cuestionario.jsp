<%-- 
    Document   : cuestionario
    Created on : 5/05/2026, 09:59:04 AM
    Author     : abrah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Evaluación Interactiva | ASI</title>
    <style>
        :root { --primary: #1e293b; --accent: #2563eb; --bg: #f1f5f9; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--bg); margin: 0; padding: 0; overflow-x: hidden; }
        
        .main-wrapper { display: flex; height: 100vh; flex-wrap: wrap; }
        
        /* Lado Izquierdo: Video */
        .video-section { flex: 1; min-width: 50%; background: #000; display: flex; flex-direction: column; justify-content: center; align-items: center; }
        .video-container { width: 90%; aspect-ratio: 16/9; }
        .video-container iframe { width: 100%; height: 100%; border-radius: 8px; border: none; }

        /* Lado Derecho: Cuestionario */
        .quiz-section { flex: 1; min-width: 400px; background: white; padding: 40px; display: flex; flex-direction: column; box-shadow: -5px 0 15px rgba(0,0,0,0.05); }
        .quiz-header { border-bottom: 2px solid var(--bg); margin-bottom: 30px; padding-bottom: 10px; }
        
        /* Lógica de Pasos (Preguntas) */
        .question-step { display: none; animation: fadeIn 0.5s ease; }
        .question-step.active { display: block; }

        @keyframes fadeIn { from { opacity: 0; transform: translateX(20px); } to { opacity: 1; transform: translateX(0); } }

        .question-text { font-size: 1.2rem; font-weight: 600; color: var(--primary); margin-bottom: 20px; }
        .option-label { display: block; padding: 15px; margin: 10px 0; border: 2px solid #e2e8f0; border-radius: 8px; cursor: pointer; transition: 0.3s; }
        .option-label:hover { background: #f8fafc; border-color: var(--accent); }
        .option-label input { margin-right: 10px; }

        .controls { margin-top: auto; display: flex; justify-content: space-between; align-items: center; }
        .btn { padding: 12px 25px; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; font-size: 1rem; }
        .btn-next { background: var(--accent); color: white; }
        .btn-finish { background: #16a34a; color: white; display: none; }
        .btn-back { background: #64748b; color: white; text-decoration: none; display: inline-block; padding: 10px; font-size: 0.8rem; border-radius: 4px; margin-bottom: 20px; }

        .progress-bar { height: 6px; background: #e2e8f0; border-radius: 3px; margin-bottom: 20px; position: relative; }
        .progress-fill { height: 100%; background: var(--accent); width: 20%; transition: 0.4s; border-radius: 3px; }

        #resultado { display: none; text-align: center; }
    </style>
</head>
<body>

    <div class="main-wrapper">
        
        <div class="video-section">
            <div class="video-container">
                <iframe src="https://www.youtube.com/embed/boQKl5BkPfs" allowfullscreen></iframe>
            </div>
            <p style="color: white; margin-top: 20px; opacity: 0.7;">Consulte el video si tiene dudas con las preguntas.</p>
        </div>

        <div class="quiz-section">
            <a href="principal.jsp" class="btn-back">← Volver al Menú</a>
            
            <div class="quiz-header">
                <h2 style="margin:0;">Test de Seguridad</h2>
                <div id="status" style="color: #64748b; font-size: 0.9rem; margin-top: 5px;">Pregunta 1 de 5</div>
            </div>

            <div class="progress-bar">
                <div id="progressFill" class="progress-fill"></div>
            </div>

            <form id="quizForm">
                <div class="question-step active" id="step1">
                    <p class="question-text">1. ¿Qué representan las contraseñas en la seguridad de internet?</p>
                    <label class="option-label"><input type="radio" name="q1" value="a"> Un requisito opcional</label>
                    <label class="option-label"><input type="radio" name="q1" value="correct"> El blindaje y la primera línea de defensa</label>
                    <label class="option-label"><input type="radio" name="q1" value="c"> Un método para guardar correos</label>
                </div>

                <div class="question-step" id="step2">
                    <p class="question-text">2. ¿Qué tipos de biometría se mencionan para dispositivos avanzados?</p>
                    <label class="option-label"><input type="radio" name="q2" value="a"> Firma y nombre completo</label>
                    <label class="option-label"><input type="radio" name="q2" value="correct"> Huella digital, voz y reconocimiento facial</label>
                    <label class="option-label"><input type="radio" name="q2" value="c"> Solo patrón de dibujo</label>
                </div>

                <div class="question-step" id="step3">
                    <p class="question-text">3. Según el video, ¿qué combinaciones hacen una contraseña imbatible?</p>
                    <label class="option-label"><input type="radio" name="q3" value="correct"> Números, mayúsculas, minúsculas y símbolos</label>
                    <label class="option-label"><input type="radio" name="q3" value="b"> Nombres de mascotas y fechas</label>
                    <label class="option-label"><input type="radio" name="q3" value="c"> Palabras fáciles de recordar como "contraseña"</label>
                </div>

                <div class="question-step" id="step4">
                    <p class="question-text">4. ¿Cuál es el mínimo de caracteres recomendado para una contraseña segura?</p>
                    <label class="option-label"><input type="radio" name="q4" value="a"> 6 caracteres</label>
                    <label class="option-label"><input type="radio" name="q4" value="correct"> Al menos 8 caracteres</label>
                    <label class="option-label"><input type="radio" name="q4" value="c"> No hay un mínimo recomendado</label>
                </div>

                <div class="question-step" id="step5">
                    <p class="question-text">5. ¿Qué datos personales se deben EVITAR al crear una contraseña?</p>
                    <label class="option-label"><input type="radio" name="q5" value="a"> Símbolos extraños</label>
                    <label class="option-label"><input type="radio" name="q5" value="b"> Letras mayúsculas</label>
                    <label class="option-label"><input type="radio" name="q5" value="correct"> Nombres completos, de mascotas o de la empresa</label>
                </div>
            </form>

            <div id="resultado">
                <h2 id="resTitulo"></h2>
                <p id="resMensaje" style="font-size: 1.1rem; line-height: 1.6;"></p>
                <button class="btn btn-next" onclick="location.reload()">Reiniciar Test</button>
            </div>

            <div class="controls" id="quizControls">
                <div style="font-weight: bold; color: var(--primary);" id="feedback"></div>
                <button type="button" class="btn btn-next" id="nextBtn" onclick="nextQuestion()">Siguiente Pregunta</button>
                <button type="button" class="btn btn-finish" id="finishBtn" onclick="finishQuiz()">Finalizar Evaluación</button>
            </div>
        </div>
    </div>

    <script>
        let currentStep = 1;
        const totalSteps = 5;

        function nextQuestion() {
            // Verificar si seleccionó algo antes de avanzar
            const currentInputs = document.querySelectorAll('#step' + currentStep + ' input');
            let selected = false;
            currentInputs.forEach(input => { if(input.checked) selected = true; });

            if (!selected) {
                alert("Por favor, seleccione una opción para continuar.");
                return;
            }

            // Cambiar de paso
            document.getElementById('step' + currentStep).classList.remove('active');
            currentStep++;
            document.getElementById('step' + currentStep).classList.add('active');

            // Actualizar interfaz
            updateUI();
        }

        function updateUI() {
            document.getElementById('status').innerText = "Pregunta " + currentStep + " de " + totalSteps;
            document.getElementById('progressFill').style.width = (currentStep * 20) + "%";

            if (currentStep === totalSteps) {
                document.getElementById('nextBtn').style.display = 'none';
                document.getElementById('finishBtn').style.display = 'block';
            }
        }

        function finishQuiz() {
            const form = document.getElementById('quizForm');
            const data = new FormData(form);
            let correctas = 0;
            
            // Verificar última pregunta antes de terminar
            const lastInputs = document.querySelectorAll('#step5 input');
            let selected = false;
            lastInputs.forEach(input => { if(input.checked) selected = true; });
            if (!selected) { alert("Responda la última pregunta."); return; }

            for (let value of data.values()) {
                if (value === 'correct') correctas++;
            }

            // Mostrar Resultados
            document.getElementById('quizForm').style.display = 'none';
            document.getElementById('quizControls').style.display = 'none';
            document.getElementById('status').parentElement.style.display = 'none';
            
            const resDiv = document.getElementById('resultado');
            resDiv.style.display = 'block';
            
            if (correctas >= 4) {
                document.getElementById('resTitulo').innerText = "✅ ¡Excelente trabajo!";
                document.getElementById('resMensaje').innerText = "Has acertado " + correctas + " de 5. Eres un experto en la primera línea de defensa digital.";
            } else {
                document.getElementById('resTitulo').innerText = "⚠️ Sigue practicando";
                document.getElementById('resMensaje').innerText = "Acertaste " + correctas + " de 5. Recuerda que usar biometría y claves de 8+ caracteres es vital.";
            }
        }
    </script>
</body>
</html>