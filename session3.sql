SELECT * FROM session3.dondathang;

select nhacungcap.maNCC, nhacungcap.tenNCC, dondathang.ngayDH
from dondathang
JOIN nhacungcap ON nhacungcap.maNCC = dondathang.maNCC
where dondathang.ngayDH between '2023-08-03' and '2023-08-05'
;


select vattu.maVT, vattu.tenVT, 
nhacungcap.maNCC, nhacungcap.tenNCC,
dondathang.ngayDH
from dondathang
JOIN nhacungcap ON nhacungcap.maNCC = dondathang.maNCC
JOIN chitietdondathang ON chitietdondathang.maVT = dondathang.soDH
JOIN vattu ON chitietdondathang.maVT = vattu.maVT
WHERE dondathang.ngayDH BETWEEN '2023-08-02' AND '2023-08-04'
order by nhacungcap.tenNCC, vattu.tenVT
;

