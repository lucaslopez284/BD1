/* Hallar aquellos pacientes que para todas sus consultas médicas siempre hayan
dejado su número de teléfono primario (nunca el teléfono secundario). */
SELECT DISTINCT
	p.patient_id AS Identificador,
    p.patient_name AS Nombre
FROM patient p
INNER JOIN appointment a ON p.patient_id = a.patient_id
WHERE p.primary_phone = a.contact_phone
AND p.patient_id NOT IN(
	SELECT p2.patient_id
    FROM patient p2
    INNER JOIN appointment a2 ON p2.patient_id = a2.patient_id
	WHERE a2.contact_phone <> p2.primary_phone
    OR a2.contact_phone IS NULL);