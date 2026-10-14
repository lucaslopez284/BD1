/* a. Obtener la cantidad de doctores por cada 
paciente que tiene disponible en su ciudad */
SELECT 
	dp.patient_id AS "Identificador paciente",
    COUNT(dp.doctor_id) AS "Cantidad doctores"
FROM appointments.doctors_per_patients dp
GROUP BY dp.patient_id;

/* b. Obtener los nombres de los pacientes sin doctores en su ciudad */
SELECT 
	p.patient_id AS Identificador, 
	patient_name AS Nombre
FROM patient p
WHERE p.patient_id NOT IN(
	SELECT dp.patient_id
    FROM doctors_per_patients dp);
    
/* c. Obtener los doctores que comparten ciudad con más de cinco pacientes. */
SELECT 
	dp.doctor_id AS "Identificador doctor",
    COUNT(dp.patient_id) AS "Cantidad pacientes"
FROM appointments.doctors_per_patients dp
GROUP BY dp.doctor_id
HAVING COUNT(dp.patient_id) > 5;