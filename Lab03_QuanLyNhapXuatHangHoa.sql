------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 18/03/2022
   Người thực hiện: Hoàng Nghĩa Minh Bảo
   Mã số sinh viên: 2011356
   Lab03: Quản lý nhập xuất hàng hóa
*/
------------------------------------------------
--Lệnh tạo CSDL
CREATE DATABASE Lab03_QuanLyNhapXuatHangHoa
go
--Lệnh sử dụng CSDL
use Lab03_QuanLyNhapXuatHangHoa
--Lệnh tạo các bảng
create table HangHoa
(
MaHH char(5) primary key,
TenHH nvarchar(30) not null,
DVT nvarchar(5),
SoLuongTon int check(SoLuongTon>=0)
)
go
create table DoiTac
(
MaDT char(5) primary key,
TenDT nvarchar(25) not null,
DiaChi nvarchar(40) not null,
DienThoai char(10)
)
go
create table HoaDon
(
SoHD char(5) primary key,
NgayLapHD datetime,
MaDT char(5) references DoiTac(MaDT),
TongTG int check(TongTG >= 0)
)
go
create table KhaNangCC
(
MaDT char(5) references DoiTac(MaDT),
MaHH char(5) references HangHoa(MaHH),
primary key (MaDT, MaHH)
)
go
create table CT_HoaDon
(
SoHD char(5) references HoaDon(SoHD),
MaHH char(5) references HangHoa(MaHH),
DonGia int check(DonGia>=0),
SoLuong int check(SoLuong>=0)
)
-----Lệnh xem dữ liệu chứa trong bảng------
select * from HangHoa
select * from DoiTac
select * from HoaDon
select * from KhaNangCC
select * from CT_HoaDon
----NHẬP DỮ LIỆU CHO CÁC BẢNG-------
--Nhập bảng HangHoa
insert into HangHoa values ('CPU01', 'CPU INTEL, CELERON 600 BOX', N'CÁI', 5)
insert into HangHoa values ('CPU02', 'CPU INTEL, PHI 700', N'CÁI', 10)
insert into HangHoa values ('CPU03', 'CPU AMD K7 ATHL, ON 600', N'CÁI',8)
insert into HangHoa values ('HDD01', 'HDD 10.2 GB QUANTUM', N'CÁI', 10)
insert into HangHoa values ('HDD02', 'HDD 13.6 GB SEAGATE', N'CÁI', 15)
insert into HangHoa values ('HDD03', 'HDD 20 GB QUANTUM', N'CÁI', 6)
insert into HangHoa values ('KB01', 'KB GENIUS', N'CÁI', 12)
insert into HangHoa values ('KB02', 'KB MITSUMIMI', N'CÁI', 5)
insert into HangHoa values ('MB01', 'GIGABYTE CHIPSET INTEL', N'CÁI', 10)
insert into HangHoa values ('MB02', 'ACOPR BX CHIPSET VIA', N'CÁI', 10)
insert into HangHoa values ('MB03', 'INTEL PHI CHIPSET INTEL', N'CÁI', 10)
insert into HangHoa values ('MB04', 'ECS CHIPSET SIS', N'CÁI', 10)
insert into HangHoa values ('MB05', 'ECS CHIPSET VIA', N'CÁI', 10)
insert into HangHoa values ('MNT01', 'SAMSUNG 14" SYNCMASTER', N'CÁI', 5)
insert into HangHoa values ('MNT02', 'LG 14"', N'CÁI', 5)
insert into HangHoa values ('MNT03', 'ACER 14"', N'CÁI', 8)
insert into HangHoa values ('MNT04', 'PHILIPS 14"', N'CÁI', 6)
insert into HangHoa values ('MNT05', 'VIEWSONIC 14"', N'CÁI', 7)
--Xem bảng HangHoa
select * from HangHoa
--Nhập bảng DoiTac
insert into DoiTac values ('CC001', N'Cty TNC', N'176 BTX Q1 - TPHCM', '08.8250259')
insert into DoiTac values ('CC002', N'Cty Hoàng Long', N'15A TTT Q1 - TPHCM', '08.8250898')
insert into DoiTac values ('CC003', N'Cty Hợp Nhất', N'152 BTX Q1 - TPHCM', '08.8252376')
insert into DoiTac values ('K0001', N'Nguyễn Minh Hải', N'91 Nguyễn Văn Trỗi Tp. Đà Lạt', '063.831129')
insert into DoiTac values ('K0002', N'Như Quỳnh', N'21 Điện Biên Phủ, N. Trang', '058590270')
insert into DoiTac values ('K0003', N'Trần Nhật Duật', N'176 BTX Q1 - TPHCM', '054.848376')
insert into DoiTac values ('K0004', N'Phan Nguyễn Hùng Anh', N'11 Nam Kỳ Khởi Nghĩa - TP. Đà Lạt', '063.823409')
--Xem bảng DoiTac
select * from DoiTac
--Nhập bảng HoaDon
set dateformat dmy
go
insert into HoaDon values ('N0001', '25/01/2006', 'CC001', NULL)
insert into HoaDon values ('N0002', '01/05/2006', 'CC002', NULL)
insert into HoaDon values ('X0001', '12/05/2006', 'K0001', NULL)
insert into HoaDon values ('X0002', '16/06/2006', 'K0002', NULL)
insert into HoaDon values ('X0003', '20/04/2006', 'K0001', NULL)
--Xem bảng HoaDon
select * from HoaDon
--Nhập bảng KhaNangCC
insert into KhaNangCC values ('CC001', 'CPU01')
insert into KhaNangCC values ('CC001', 'HDD03')
insert into KhaNangCC values ('CC001', 'KB01')
insert into KhaNangCC values ('CC001', 'MB02')
insert into KhaNangCC values ('CC001', 'MB04')
insert into KhaNangCC values ('CC001', 'MNT01')
insert into KhaNangCC values ('CC002', 'CPU01')
insert into KhaNangCC values ('CC002', 'CPU02')
insert into KhaNangCC values ('CC002', 'CPU03')
insert into KhaNangCC values ('CC002', 'KB02')
insert into KhaNangCC values ('CC002', 'MB01')
insert into KhaNangCC values ('CC002', 'MB05')
insert into KhaNangCC values ('CC002', 'MNT03')
insert into KhaNangCC values ('CC003', 'HDD01')
insert into KhaNangCC values ('CC003', 'HDD02')
insert into KhaNangCC values ('CC003', 'HDD03')
insert into KhaNangCC values ('CC003', 'MB03')
--Xem bảng KhaNangCC
select * from KhaNangCC
--Nhập bảng CT_HoaDon
insert into CT_HoaDon values ('N0001', 'CPU01', 63, 10)
insert into CT_HoaDon values ('N0001', 'HDD03', 97, 7)
insert into CT_HoaDon values ('N0001', 'KB01', 3, 5)
insert into CT_HoaDon values ('N0001', 'MB02', 57, 5)
insert into CT_HoaDon values ('N0001', 'MNT01', 112, 3)
insert into CT_HoaDon values ('N0002', 'CPU02', 115, 3)
insert into CT_HoaDon values ('N0002', 'KB02', 5, 7)
insert into CT_HoaDon values ('N0002', 'MNT03', 111, 5)
insert into CT_HoaDon values ('X0001', 'CPU01', 67, 2)
insert into CT_HoaDon values ('X0001', 'HDD03', 100, 2)
insert into CT_HoaDon values ('X0001', 'KB01', 5, 2)
insert into CT_HoaDon values ('X0001', 'MB02', 62, 1)
insert into CT_HoaDon values ('X0002', 'CPU01', 67, 1)
insert into CT_HoaDon values ('X0002', 'KB02', 7, 3)
insert into CT_HoaDon values ('X0002', 'MNT01', 115, 2)
insert into CT_HoaDon values ('X0003', 'CPU01', 67, 1)
insert into CT_HoaDon values ('X0003', 'MNT03', 115, 2)
--Xem bảng CT_HoaDon
select * from CT_HoaDon
--TRUY VẤN DỮ LIỆU--
--1. Liệt kê các mặt hàng thuộc loại đĩa cứng
--a. Các mặt hàng loại CPU
select * from HangHoa
where MaHH like 'CPU%'
--b. Các mặt hàng loại HDD
select * from HangHoa
where MaHH like 'HDD%'
--c. Các mặt hàng loại KB
select * from HangHoa
where MaHH like 'KB%'
--d. Các mặt hàng loại MB
select * from HangHoa
where MaHH like 'MB%'
--e. Các mặt hàng loại MNT
select * from HangHoa
where MaHH like 'MNT%'
--2. Liệt kê các mặt hàng có số lượng tồn trên 10
select * from HangHoa
where SoLuongTon >= 10
--3. Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
select * from DoiTac
where DiaChi like '%TPHCM'
--4. Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: SoHD, NgayLapHD; tên, địa chỉ và điện thoại của nhà cung cấp; số mặt hàng
select B.SoHD, NgayLapHD, A.TenDT, A.DiaChi, A.DienThoai, COUNT(C.MaHH) as SoMatHang
from DoiTac A, HoaDon B, CT_HoaDon C
where A.MaDT = B.MaDT and MONTH(B.NgayLapHD)=5 and YEAR(B.NgayLapHD)=2006 and B.SoHD = C.SoHD and B.SoHD like 'N%'
group by A.MaDT, NgayLapHD, A.TenDT, A.DiaChi, A.DienThoai, B.SoHD
--5. Cho biết tên các nhà cung cấp có cung cấp đĩa cứng
--a. Các nhà cung cấp có cung cấp đĩa cứng CPU
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and B.MaHH like 'CPU%'
--b. Các nhà cung cấp có cung cấp đĩa cứng HDD
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and B.MaHH like 'HDD%'
--c. Các nhà cung cấp có cung cấp đĩa cứng KB
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and B.MaHH like 'KB%'
--d. Các nhà cung cấp có cung cấp đĩa cứng MB
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and B.MaHH like 'MB%'
--e. Các nhà cung cấp có cung cấp đĩa cứng MNT
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and B.MaHH like 'MNT%'
--6. Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai, COUNT(C.MaHH) as SoHangHoa
from DoiTac A, KhaNangCC B, CT_HoaDon C
where A.MaDT = B.MaDT and B.MaHH = C.MaHH
group by A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
having COUNT(C.MaHH) >= all (select COUNT(D.MaHH)
							 from CT_HoaDon D
							 group by D.SoHD)
--7. Cho biết tên nhà cung cấp không cung cấp đĩa cứng
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai, COUNT(C.MaHH) as SoHangHoa
from DoiTac A, KhaNangCC B, CT_HoaDon C
where A.MaDT = B.MaDT and B.MaHH = C.MaHH
group by A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
having COUNT(C.MaHH) <= all (select COUNT(D.MaHH)
							 from CT_HoaDon D
							 group by D.SoHD)
--8. Cho biết thông tin của mặt hàng chưa bán được
--9. Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất (tính theo số lượng)
--10. Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
--11. Cho biết hóa đơn nhập nhiều mặt hàng nhất
--12. Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
--13. Cho biết tên các mặt hàng không bán được trong tháng 6/2006
--14. Cho biết cửa hàng bán bao nhiêu mặt hàng
--15. Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
--16. Cho biết thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất
--17. Tính tổng doanh thu năm 2006
--18. Cho biết loại mặt hàng bán chạy nhất
--19. Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: MaHH, TenHH, DVT, tổng số lượng, tổng thành tiền
--20. Liệt kê thông tin của mặt hàng có nhiều người mua nhất
--21. Tính và cập nhật tổng trị giá của các hóa đơn
--THỦ TUC VÀ HÀM
--I. Viết các hàm sau:
--1. Tính tổng số lượng nhập trong một khoảng thời gian của một mặt hàng cho trước
--2. Tính tổng số lượng xuất trong một khoảng thời gian của một mặt hàng cho trước
--3. Tính tổng doanh thu trong một tháng cho trước
--4. Tính tổng doanh thu của một mặt hàng trong một khoảng thời gian cho trước
--5. Tính tổng số tiền nhập hàng trong một khoảng thời gian cho trước
--6. Tính tổng số tiền của một hóa đơn cho trước
--II. Viết các thủ tục sau:
--1. Cập nhật số lượng tồn của một mặt hàng khi nhập hàng hoặc xuất hàng
--2. Cập nhật tổng trị giá của một hóa đơn
--3. In đầy đủ thông tin của một hóa đơn