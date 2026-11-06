-- Tugas Database Technology nomor 2

USE reservasi_hotel;

-- Query 1
-- Menampilkan reservasi yang hotelnya berada di Surabaya
SELECT DISTINCT
    r.id_reservasi,
    r.tanggal,
    r.nama_tamu,
    h.id_hotel,
    h.kota
FROM reservasi AS r
JOIN detail_reservasi AS d ON r.id_reservasi = d.id_reservasi
JOIN kamar AS k            ON d.id_kamar = k.id_kamar
JOIN hotel AS h            ON k.id_hotel = h.id_hotel
WHERE h.kota = 'Surabaya'
ORDER BY r.tanggal, r.id_reservasi;

-- Query 2
-- Mencari tipe kamar yang paling sering dipesan
WITH frekuensi_tipe AS (
    SELECT
        k.tipe,
        COUNT(d.id_detail) AS jumlah_pemesanan
    FROM detail_reservasi AS d
    JOIN kamar AS k ON d.id_kamar = k.id_kamar
    GROUP BY k.tipe
)
SELECT
    tipe,
    jumlah_pemesanan
FROM frekuensi_tipe
WHERE jumlah_pemesanan = (SELECT MAX(jumlah_pemesanan) FROM frekuensi_tipe)
ORDER BY tipe;

-- Query 3
-- Menampilkan detail reservasi sekaligus menghitung total biaya
SELECT
    r.id_reservasi,
    r.nama_tamu,
    r.tanggal,
    h.id_hotel,
    h.kota,
    k.id_kamar,
    k.tipe,
    k.tarif,
    d.jumlah_malam,
    (k.tarif * d.jumlah_malam) AS total_biaya
FROM detail_reservasi AS d
JOIN reservasi AS r ON d.id_reservasi = r.id_reservasi
JOIN kamar AS k     ON d.id_kamar = k.id_kamar
JOIN hotel AS h     ON k.id_hotel = h.id_hotel
ORDER BY r.id_reservasi, d.id_detail;
