-- Take Home Exam Database  nomor 2

-- Menghapus database jika sebelumnya sudah pernah dibuat
DROP DATABASE IF EXISTS reservasi_hotel;

CREATE DATABASE reservasi_hotel
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE reservasi_hotel;

-- Tabel hotel
CREATE TABLE hotel (
    id_hotel CHAR(3)     NOT NULL,
    kota     VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_hotel),
    INDEX idx_hotel_kota (kota)
) ENGINE = InnoDB;

-- Tabel kamar
CREATE TABLE kamar (
    id_kamar CHAR(3)       NOT NULL,
    tipe     VARCHAR(30)   NOT NULL,
    tarif    DECIMAL(12, 2) NOT NULL,
    id_hotel CHAR(3)       NOT NULL,
    PRIMARY KEY (id_kamar),
    CONSTRAINT fk_kamar_hotel
        FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel)
) ENGINE = InnoDB;

-- Tabel reservasi
CREATE TABLE reservasi (
    id_reservasi CHAR(4)      NOT NULL,
    tanggal      DATE         NOT NULL,
    nama_tamu    VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_reservasi)
) ENGINE = InnoDB;

-- Tabel detail reservasi
CREATE TABLE detail_reservasi (
    id_detail    CHAR(4)        NOT NULL,
    id_reservasi CHAR(4)        NOT NULL,
    id_kamar     CHAR(3)        NOT NULL,
    jumlah_malam TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (id_detail),
    CONSTRAINT fk_detail_reservasi
        FOREIGN KEY (id_reservasi) REFERENCES reservasi (id_reservasi),
    CONSTRAINT fk_detail_kamar
        FOREIGN KEY (id_kamar) REFERENCES kamar (id_kamar)
) ENGINE = InnoDB;

-- Data hotel
INSERT INTO hotel (id_hotel, kota) VALUES
    ('H01', 'Surabaya'),
    ('H02', 'Bandung'),
    ('H03', 'Jakarta');

-- Data kamar
INSERT INTO kamar (id_kamar, tipe, tarif, id_hotel) VALUES
    ('K01', 'Standard', 350000.00, 'H01'),
    ('K02', 'Deluxe',   550000.00, 'H01'),
    ('K03', 'Suite',    900000.00, 'H01'),
    ('K04', 'Standard', 300000.00, 'H02'),
    ('K05', 'Deluxe',   500000.00, 'H02'),
    ('K06', 'Standard', 450000.00, 'H03'),
    ('K07', 'Suite',    850000.00, 'H03'),
    ('K08', 'Deluxe',   600000.00, 'H01');

-- Data reservasi
INSERT INTO reservasi (id_reservasi, tanggal, nama_tamu) VALUES
    ('R001', '2026-10-01', 'Budi Santoso'),
    ('R002', '2026-10-03', 'Sari Dewi'),
    ('R003', '2026-10-05', 'Andi Pratama'),
    ('R004', '2026-10-07', 'Maya Putri'),
    ('R005', '2026-10-10', 'Rina Kurnia'),
    ('R006', '2026-10-12', 'Dedi Saputra'),
    ('R007', '2026-10-15', 'Lina Marlina'),
    ('R008', '2026-10-18', 'Agus Setiawan'),
    ('R009', '2026-10-20', 'Fajar Nugroho'),
    ('R010', '2026-10-23', 'Citra Lestari');

-- Data kamar yang dipesan
-- Pada R009 sengaja dibuat memesan dua kamar untuk pengujian
INSERT INTO detail_reservasi (id_detail, id_reservasi, id_kamar, jumlah_malam) VALUES
    ('D001', 'R001', 'K01', 2),
    ('D002', 'R002', 'K02', 3),
    ('D003', 'R003', 'K04', 1),
    ('D004', 'R004', 'K07', 2),
    ('D005', 'R005', 'K03', 2),
    ('D006', 'R006', 'K05', 3),
    ('D007', 'R007', 'K02', 1),
    ('D008', 'R008', 'K06', 2),
    ('D009', 'R009', 'K01', 2),
    ('D010', 'R009', 'K03', 1),
    ('D011', 'R010', 'K08', 2);

-- Mengecek apakah data sudah masuk
SELECT 'Database reservasi_hotel siap digunakan.' AS status;
SELECT COUNT(*) AS jumlah_hotel   FROM hotel;
SELECT COUNT(*) AS jumlah_kamar   FROM kamar;
SELECT COUNT(*) AS jumlah_reservasi FROM reservasi;
SELECT COUNT(*) AS jumlah_detail  FROM detail_reservasi;
