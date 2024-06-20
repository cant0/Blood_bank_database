create user fprzepio from login fprzepio;
exec sp_addrolemember 'db_owner', fprzepio;

-- Tabela Pacjenci
CREATE TABLE Pacjenci (
    PacjentID INT identity constraint pk_pacjentid primary key,
    ImieNazwisko VARCHAR(255) NOT NULL,
    GrupaKrwi VARCHAR(3) NOT NULL,
    Choroba VARCHAR(255)
);

-- Tabela Dawcy
CREATE TABLE Dawcy (
    DawcaID INT identity constraint pk_dawcaid primary key ,
    ImieNazwisko VARCHAR(255) NOT NULL,
    GrupaKrwi VARCHAR(3) NOT NULL,
    RaportMedyczny TEXT,
    Adres VARCHAR(255),
    NumerKontaktowy VARCHAR(15)
);

-- Tabela BankiKrwi
CREATE TABLE BankiKrwi (
    BankKrwiID INT identity constraint pk_bankikrwiid primary key ,
    Nazwa VARCHAR(255) NOT NULL,
    Adres VARCHAR(255),
    DaneKontaktowe VARCHAR(255)
);

-- Tabela DawcyKrwi
CREATE TABLE DawcyKrwi (
    DawcaKrewID INT identity constraint pk_dawcakrewid primary key ,
    DawcaID INT NOT NULL,
    BankKrwiID INT NOT NULL,
    DataDonacji DATE NOT NULL,
    FOREIGN KEY (DawcaID) REFERENCES Dawcy(DawcaID),
    FOREIGN KEY (BankKrwiID) REFERENCES BankiKrwi(BankKrwiID)
);

-- Tabela DopasowanieDawcyPacjenta
CREATE TABLE DopasowanieDawcyPacjenta (
    DopasowanieID INT identity constraint pk_dopasowanieid primary key ,
    PacjentID INT NOT NULL,
    DawcaID INT NOT NULL,
    DataDopasowania DATE NOT NULL,
    FOREIGN KEY (PacjentID) REFERENCES Pacjenci(PacjentID),
    FOREIGN KEY (DawcaID) REFERENCES Dawcy(DawcaID)
);

-- Tabela Transfuzje
CREATE TABLE Transfuzje (
    TransfuzjaID INT identity constraint pk_transfuzjaid primary key ,
    PacjentID INT NOT NULL,
    DawcaID INT NOT NULL,
    DataTransfuzji DATE NOT NULL,
    IloscKrwi DECIMAL(5,2) NOT NULL,
    BankKrwiID INT NOT NULL,
    FOREIGN KEY (PacjentID) REFERENCES Pacjenci(PacjentID),
    FOREIGN KEY (DawcaID) REFERENCES Dawcy(DawcaID),
    FOREIGN KEY (BankKrwiID) REFERENCES BankiKrwi(BankKrwiID)
);

-- Tabela HistorieDawcy
CREATE TABLE HistorieDawcy (
    HistoriaID INT identity constraint pk_historiaid primary key ,
    DawcaID INT NOT NULL,
    DataDonacji DATE NOT NULL,
    IloscKrwi DECIMAL(5,2) NOT NULL,
    Uwagi TEXT,
    FOREIGN KEY (DawcaID) REFERENCES Dawcy(DawcaID)
);

-- Tabela WynikiBadan
CREATE TABLE WynikiBadan (
    WynikID INT identity constraint pk_wynikid primary key ,
    DawcaID INT NOT NULL,
    DataBadania DATE NOT NULL,
    Wynik TEXT NOT NULL,
    TypBadania VARCHAR(255) NOT NULL,
    FOREIGN KEY (DawcaID) REFERENCES Dawcy(DawcaID)
);

-- Tabela Powiadomienia
CREATE TABLE Powiadomienia (
    PowiadomienieID INT identity constraint pk_powiadomienieid primary key ,
    DawcaID INT,
    PacjentID INT,
    Tresc TEXT NOT NULL,
    DataWyslania DATE NOT NULL,
    Status VARCHAR(50),
    FOREIGN KEY (DawcaID) REFERENCES Dawcy(DawcaID),
    FOREIGN KEY (PacjentID) REFERENCES Pacjenci(PacjentID)
);

-- Tabela Pracownicy
CREATE TABLE Pracownicy (
    PracownikID INT identity constraint pk_pracownikid primary key,
    ImieNazwisko VARCHAR(255) NOT NULL,
    Stanowisko VARCHAR(255) NOT NULL,
    Adres VARCHAR(255),
    NumerKontaktowy VARCHAR(15),
    Email VARCHAR(255),
    BankKrwiID INT NOT NULL,
    FOREIGN KEY (BankKrwiID) REFERENCES BankiKrwi(BankKrwiID)
);