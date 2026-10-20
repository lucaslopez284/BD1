/* Crear un stored procedure que sirva para agregar un appointment, junto el registro
de un doctor que lo atendió (medical_review) y un medicamento que se le recetó
(prescribed_medication), dentro de una sola transacción. El stored procedure debe
recibir los siguientes parámetros: patient_id, doctor_id, appointment_duration,
contact_phone y medication_name. El appointment_date será la fecha actual. Los
atributos restantes deben dejarse en NULL. */

DELIMITER //
CREATE PROCEDURE ejercicio_9(
	IN p_patient_id int,
    IN p_doctor_id int, 
    IN p_appointment_duration int, 
    IN p_contact_phone varchar(255),
    IN p_medication_name varchar(255))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		ROLLBACK;
    START TRANSACTION;
    INSERT INTO appointment (patient_id, appointment_date, appointment_duration, contact_phone, observations, payment_card)
	VALUES (p_patient_id, now(), p_appointment_duration, p_contact_phone, NULL, NULL);
    INSERT INTO medical_review (patient_id, appointment_date, doctor_id)
	VALUES (p_patient_id, now(), p_doctor_id);
    INSERT INTO prescribed_medication (patient_id, appointment_date, medication_name)
	VALUES (p_patient_id, now(), p_medication_name);
	COMMIT;
END //
DELIMITER ;

/* Ejecutar el stored procedure del punto 9 con los siguientes datos:
patient_id: 10004427
doctor_id: 1003
appointment_duration: 30
contact_phone: +54 15 2913 9963
medication_name: ‘Paracetamol’ */

call ejercicio_9(10004427, 1003, 30, "+54 15 2913 9963", "Paracetamol");