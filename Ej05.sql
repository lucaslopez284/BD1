/* Escribe y ejecute la sentencia correspondiente para crear la siguiente tabla:
APPOINTMENTS_PER_PATIENT
idApP: int(11) PK AI
patient_id: int(11)
count_appointments: int(11)
last_update: datetime
user: varchar(16) */
CREATE TABLE appointments.appointments_per_patient(
    idApP int(11) auto_increment primary key,
    patient_id int(11),
    count_appointments int(11),
    last_update datetime,
    `user` varchar(16));