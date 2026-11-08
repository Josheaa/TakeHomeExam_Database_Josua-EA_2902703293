-- Take Home Exam Database  nomor 2

USE reservasi_hotel;

-- Bukti penggunaan indeks pada Query 1
-- Query ini sama dengan Query 1 hanya ditambah EXPLAIN untuk menampilkan perencanaan eksekusi
EXPLAIN
SELECT DISTINCT
    r.id_reservasi, r.tanggal, r.nama_tamu, h.id_hotel, h.kota
FROM reservasi AS r
JOIN detail_reservasi AS d ON r.id_reservasi = d.id_reservasi
JOIN kamar AS k            ON d.id_kamar = k.id_kamar
JOIN hotel AS h            ON k.id_hotel = h.id_hotel
WHERE h.kota = 'Surabaya'
ORDER BY r.tanggal, r.id_reservasi;