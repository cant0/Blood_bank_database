create table dbo.blood_bank
(
    bank_id    int         not null
        constraint PK__blood_ba__4076F70352A54453
            primary key,
    bankName   varchar(50) not null,
    address    varchar(50) not null,
    city       varchar(50) not null,
    postalcode varchar(20) not null,
    phone      varchar(15) not null
)
go

create table dbo.blood_test
(
    test_id    int         not null
        constraint PK__blood_te__F3FF1C0280C5ABE3
            primary key,
    donor_id   int         not null
        constraint FK__blood_tes__donor__5B438874
            references dbo.donor,
    testDate   date        not null,
    testResult varchar(50) not null
)
go

create table dbo.blood_transaction
(
    transaction_id  int           not null
        constraint PK__blood_tr__85C600AFD3A56DFD
            primary key,
    patient_id      int           not null
        constraint FK__blood_tra__patie__567ED357
            references dbo.patient,
    donor_id        int           not null
        constraint FK__blood_tra__donor__5772F790
            references dbo.donor,
    bank_id         int           not null
        constraint FK__blood_tra__bank___58671BC9
            references dbo.blood_bank,
    transactionDate date          not null,
    amount          decimal(5, 2) not null
)
go

create table dbo.blood_type
(
    blood_id  int         not null
        primary key,
    bloodType varchar(10) not null
)
go

create table dbo.donor
(
    donor_id   int         not null
        constraint PK__donor__8B5B10F9C1F527BD
            primary key,
    blood_id   int         not null
        constraint FK__donor__blood_id__4EDDB18F
            references dbo.blood_type,
    firstName  varchar(50) not null,
    lastName   varchar(50) not null,
    address    varchar(50) not null,
    city       varchar(50) not null,
    postalcode varchar(20) not null,
    phone      varchar(15) not null
)
go

create table dbo.employee
(
    employee_id int         not null
        constraint PK__employee__C52E0BA8BFAE2015
            primary key,
    bank_id     int         not null
        constraint FK__employee__bank_i__5E1FF51F
            references dbo.blood_bank,
    firstName   varchar(50) not null,
    lastName    varchar(50) not null,
    title       varchar(20) not null,
    address     varchar(50) not null,
    city        varchar(50) not null,
    postalcode  varchar(20) not null,
    phone       varchar(15) not null
)
go

create table dbo.patient
(
    patient_id int           not null
        constraint PK__patient__4D5CE476A2E6A73A
            primary key,
    blood_id   int           not null
        constraint FK__patient__blood_i__4C0144E4
            references dbo.blood_type,
    firstName  varchar(50)   not null,
    lastName   varchar(50)   not null,
    address    varchar(50)   not null,
    city       varchar(50)   not null,
    postalcode varchar(20)   not null,
    phone      varbinary(15) not null
)
go

create table dbo.patientHistory
(
    history_id      int           not null
        constraint PK__patientH__096AA2E93881455D
            primary key,
    patient_id      int           not null
        constraint FK__patientHi__patie__63D8CE75
            references dbo.patient,
    transactionDate date          not null,
    amount          decimal(5, 2) not null,
    donor_id        int           not null
        constraint FK__patientHi__donor__64CCF2AE
            references dbo.donor
)
go

create table dbo.report
(
    report_id  int         not null
        constraint PK__report__779B7C58014D5059
            primary key,
    donor_id   int         not null
        constraint FK__report__donor_id__51BA1E3A
            references dbo.donor,
    reportDate date        not null,
    disease    varchar(50) not null
)
go

create table dbo.schedule
(
    schedule_id     int         not null
        constraint PK__schedule__C46A8A6F5969F7F9
            primary key,
    donor_id        int         not null
        constraint FK__schedule__donor___60FC61CA
            references dbo.donor,
    appointmentDate date        not null,
    status          varchar(20) not null
)
go