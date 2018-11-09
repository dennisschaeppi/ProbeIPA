-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 09. Nov 2018 um 16:34
-- Server-Version: 10.1.16-MariaDB
-- PHP-Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `probeipa_sozialesnetzwerk`
--

DELIMITER $$
--
-- Prozeduren
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `aendereBenutzerdaten` (IN `$id` INT, IN `$bn` VARCHAR(20), IN `$vorname` VARCHAR(30), IN `$nachname` VARCHAR(30), IN `$email` VARCHAR(50))  UPDATE benutzer SET benutzername=$bn, vorname=$vorname, nachname=$nachname, email=$email WHERE id_benutzer = $id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ensperreBenutzer` (IN `$id` INT)  UPDATE benutzer SET gesperrt = 0 WHERE id_benutzer = $id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `entferneGefaellt` (IN `$benutzer` INT, IN `$beitrag` INT)  DELETE FROM gefaellt WHERE fs_benutzer = $benutzer AND fs_beitrag = $beitrag$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `erstelleBeitrag` (IN `$titel` VARCHAR(30), IN `$beschreibung` VARCHAR(300), IN `$datum` DATETIME, IN `$benutzer` INT)  INSERT INTO beitrag(titel, beschreibung, datum, fs_benutzer) VALUES ($titel, $beschreibung, $datum, $benutzer)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadAlleBenutzer` ()  SELECT u.id_benutzer, u.benutzername, u.email FROM benutzer u$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadBeitraege` ()  SELECT b.id_beitrag, b.titel, b.beschreibung, b.datum, b.gemeldet, u.benutzername, u.id_benutzer FROM beitrag b INNER JOIN benutzer u ON b.fs_benutzer = u.id_benutzer WHERE b.gemeldet = 0 ORDER BY b.datum DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadBenutzer` (IN `$benutzername` VARCHAR(20))  SELECT b.id_benutzer, b.benutzername, b.vorname, b.nachname, b.email, b.passwort, r.bezeichnung, b.gesperrt, b.fs_benutzerrolle FROM benutzer b INNER JOIN benutzerrolle r ON b.fs_benutzerrolle = r.id_benutzerrolle WHERE b.benutzername = $benutzername OR b.email = $benutzername OR b.id_benutzer = $benutzername$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadGemeldeteBeitraege` ()  SELECT b.id_beitrag, b.titel, b.beschreibung, b.datum, b.gemeldet, u.benutzername, u.id_benutzer FROM beitrag b INNER JOIN benutzer u ON b.fs_benutzer = u.id_benutzer WHERE b.gemeldet = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadKommentare` (IN `$beitrag` INT)  SELECT k.fs_beitrag, b.benutzername, k.text, k.datum FROM kommentar k INNER JOIN benutzer b ON k.fs_benutzer = b.id_benutzer WHERE k.gemeldet=0 AND k.fs_beitrag = $beitrag$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loescheBeitrag` (IN `$id` INT)  DELETE FROM beitrag WHERE id_beitrag = $id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `meldeBeitrag` (IN `$id` INT)  UPDATE beitrag SET gemeldet = 1 WHERE id_beitrag = $id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `register` (IN `$benutzername` VARCHAR(20), IN `$vorname` VARCHAR(30), IN `$nachname` VARCHAR(30), IN `$email` VARCHAR(50), IN `$passwort` VARCHAR(255))  INSERT INTO benutzer(benutzername, vorname, nachname, email, passwort) values($benutzername, $vorname, $nachname, $email, $passwort)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registerPasswort` (IN `$id` INT, IN `$pw` VARCHAR(255))  UPDATE benutzer SET passwort = $pw WHERE id_benutzer = $id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `schreibeKommentar` (IN `$benutzer` INT, IN `$beitrag` INT, IN `$text` VARCHAR(100), IN `$datum` DATETIME)  INSERT INTO kommentar(fs_beitrag, fs_benutzer, text, datum) VALUES ($beitrag, $benutzer, $text, $datum)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `setGefaellt` (IN `$benutzer` INT, IN `$beitrag` INT)  INSERT INTO gefaellt(fs_benutzer, fs_beitrag) VALUES($benutzer, $beitrag)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sperreBenutzer` (IN `$id` INT)  UPDATE benutzer SET gesperrt = 1 WHERE id_benutzer = $id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `beitrag`
--

CREATE TABLE `beitrag` (
  `id_beitrag` int(11) NOT NULL,
  `titel` varchar(30) NOT NULL,
  `beschreibung` varchar(300) DEFAULT NULL,
  `datum` datetime NOT NULL,
  `fs_benutzer` int(11) NOT NULL,
  `gemeldet` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `beitrag`
--

INSERT INTO `beitrag` (`id_beitrag`, `titel`, `beschreibung`, `datum`, `fs_benutzer`, `gemeldet`) VALUES
(11, 'test', 'test', '2018-11-09 00:00:00', 11, 0),
(12, 'Test', 'Test', '2018-11-09 00:00:00', 11, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `benutzer`
--

CREATE TABLE `benutzer` (
  `id_benutzer` int(11) NOT NULL,
  `benutzername` varchar(20) NOT NULL,
  `vorname` varchar(30) NOT NULL,
  `nachname` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `passwort` varchar(255) NOT NULL,
  `fs_benutzerrolle` int(11) NOT NULL DEFAULT '1',
  `gesperrt` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `benutzer`
--

INSERT INTO `benutzer` (`id_benutzer`, `benutzername`, `vorname`, `nachname`, `email`, `passwort`, `fs_benutzerrolle`, `gesperrt`) VALUES
(1, 'felix', 'he', 'asd', 'asd@fsfdsdf', 'ba88c155ba898fc8b5099893036ef205', 3, 0),
(9, 'dennis', 'Dennis', 'Weibel', 'ssd@test.com', 'e62020afa72eb54a15725473e3a8475b', 1, 0),
(10, 'webgoat', 'Dennis', 'Schäppi', 'dennisschaeppi@outlook.com', '623ec00ca1d92ed6e2bbaa00ee2ec140', 1, 0),
(11, 'tester', 'Dennis', 'Schäppi', 'dennis.schaeppi@siemens.com', '08a68eec37af94301db96679e95673ca', 1, 0),
(12, 'täst', 'test123', 'test', 'test@xn--tst-qla.com', '8b634156edde77e407764d5166e34d20', 1, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `benutzerrolle`
--

CREATE TABLE `benutzerrolle` (
  `id_benutzerrolle` int(11) NOT NULL,
  `bezeichnung` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `benutzerrolle`
--

INSERT INTO `benutzerrolle` (`id_benutzerrolle`, `bezeichnung`) VALUES
(1, 'Konsument'),
(2, 'Troubleshooter'),
(3, 'Admin');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `berechtigungen`
--

CREATE TABLE `berechtigungen` (
  `id_berechtigung` int(11) NOT NULL,
  `bezeichnung` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `berechtigungen`
--

INSERT INTO `berechtigungen` (`id_berechtigung`, `bezeichnung`) VALUES
(1, 'Beitrag löschen'),
(2, 'Beitrag melden'),
(3, 'Beitrag erstellen'),
(4, 'Beitrag bearbeiten'),
(5, 'Benutzer sperren');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gefaellt`
--

CREATE TABLE `gefaellt` (
  `id_gefaellt` int(11) NOT NULL,
  `fs_benutzer` int(11) NOT NULL,
  `fs_beitrag` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kommentar`
--

CREATE TABLE `kommentar` (
  `id_kommentar` int(11) NOT NULL,
  `fs_beitrag` int(11) NOT NULL,
  `fs_benutzer` int(11) NOT NULL,
  `text` varchar(100) NOT NULL,
  `datum` datetime NOT NULL,
  `gemeldet` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `zuteilung_berechtigung`
--

CREATE TABLE `zuteilung_berechtigung` (
  `id_zuteilung` int(11) NOT NULL,
  `fs_benutzerrolle` int(11) NOT NULL,
  `fs_berechtigung` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `beitrag`
--
ALTER TABLE `beitrag`
  ADD PRIMARY KEY (`id_beitrag`),
  ADD KEY `fs_benutzer` (`fs_benutzer`);

--
-- Indizes für die Tabelle `benutzer`
--
ALTER TABLE `benutzer`
  ADD PRIMARY KEY (`id_benutzer`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `benutzername` (`benutzername`),
  ADD KEY `fs_benutzerrolle` (`fs_benutzerrolle`);

--
-- Indizes für die Tabelle `benutzerrolle`
--
ALTER TABLE `benutzerrolle`
  ADD PRIMARY KEY (`id_benutzerrolle`);

--
-- Indizes für die Tabelle `berechtigungen`
--
ALTER TABLE `berechtigungen`
  ADD PRIMARY KEY (`id_berechtigung`);

--
-- Indizes für die Tabelle `gefaellt`
--
ALTER TABLE `gefaellt`
  ADD PRIMARY KEY (`id_gefaellt`),
  ADD KEY `fs_benutzer` (`fs_benutzer`),
  ADD KEY `fs_beitrag` (`fs_beitrag`);

--
-- Indizes für die Tabelle `kommentar`
--
ALTER TABLE `kommentar`
  ADD PRIMARY KEY (`id_kommentar`),
  ADD KEY `fs_beitrag` (`fs_beitrag`),
  ADD KEY `fs_benutzer` (`fs_benutzer`);

--
-- Indizes für die Tabelle `zuteilung_berechtigung`
--
ALTER TABLE `zuteilung_berechtigung`
  ADD PRIMARY KEY (`id_zuteilung`),
  ADD KEY `fs_benutzerrolle` (`fs_benutzerrolle`),
  ADD KEY `fs_berechtigung` (`fs_berechtigung`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `beitrag`
--
ALTER TABLE `beitrag`
  MODIFY `id_beitrag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT für Tabelle `benutzer`
--
ALTER TABLE `benutzer`
  MODIFY `id_benutzer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT für Tabelle `benutzerrolle`
--
ALTER TABLE `benutzerrolle`
  MODIFY `id_benutzerrolle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT für Tabelle `berechtigungen`
--
ALTER TABLE `berechtigungen`
  MODIFY `id_berechtigung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT für Tabelle `gefaellt`
--
ALTER TABLE `gefaellt`
  MODIFY `id_gefaellt` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `kommentar`
--
ALTER TABLE `kommentar`
  MODIFY `id_kommentar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT für Tabelle `zuteilung_berechtigung`
--
ALTER TABLE `zuteilung_berechtigung`
  MODIFY `id_zuteilung` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `beitrag`
--
ALTER TABLE `beitrag`
  ADD CONSTRAINT `beitrag_ibfk_1` FOREIGN KEY (`fs_benutzer`) REFERENCES `benutzer` (`id_benutzer`);

--
-- Constraints der Tabelle `benutzer`
--
ALTER TABLE `benutzer`
  ADD CONSTRAINT `benutzer_ibfk_1` FOREIGN KEY (`fs_benutzerrolle`) REFERENCES `benutzerrolle` (`id_benutzerrolle`);

--
-- Constraints der Tabelle `gefaellt`
--
ALTER TABLE `gefaellt`
  ADD CONSTRAINT `gefaellt_ibfk_1` FOREIGN KEY (`fs_benutzer`) REFERENCES `benutzer` (`id_benutzer`),
  ADD CONSTRAINT `gefaellt_ibfk_2` FOREIGN KEY (`fs_beitrag`) REFERENCES `beitrag` (`id_beitrag`);

--
-- Constraints der Tabelle `kommentar`
--
ALTER TABLE `kommentar`
  ADD CONSTRAINT `kommentar_ibfk_1` FOREIGN KEY (`fs_beitrag`) REFERENCES `beitrag` (`id_beitrag`),
  ADD CONSTRAINT `kommentar_ibfk_2` FOREIGN KEY (`fs_benutzer`) REFERENCES `benutzer` (`id_benutzer`);

--
-- Constraints der Tabelle `zuteilung_berechtigung`
--
ALTER TABLE `zuteilung_berechtigung`
  ADD CONSTRAINT `zuteilung_berechtigung_ibfk_1` FOREIGN KEY (`fs_benutzerrolle`) REFERENCES `benutzerrolle` (`id_benutzerrolle`),
  ADD CONSTRAINT `zuteilung_berechtigung_ibfk_2` FOREIGN KEY (`fs_berechtigung`) REFERENCES `berechtigungen` (`id_berechtigung`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
