------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 25/03/2022
   Người thực hiện: Hoàng Nghĩa Minh Bảo
   Mã số sinh viên: 2011356
   Lab04: Quản lý đặt báo
*/
------------------------------------------------
--Lệnh tạo CSDL
create database Lab04_QuanLyDatBao
go
--Lệnh sử dụng CSDL
use Lab04_QuanLyDatBao
--Lệnh tạo các bảng
create table Bao_TChi
(
Ma_Bao_TC char(4) primary key,
Ten nvarchar(20) not null,
DinhKy nvarchar(15) not null,
SoLuong int check(SoLuong>=0),
GiaBan int check(GiaBan>=0)
)
go
create table PhatHanh_Bao
(
Ma_Bao_TC char(4) references Bao_TChi(Ma_Bao_TC),
So_Bao_TC int check (So_Bao_TC>=0),
Ngay_PH datetime,
primary key (Ma_Bao_TC, So_Bao_TC)
)
go
create table KH_Hang
(
MaKH char(4) primary key,
TenKH nvarchar(5) not null,
DC_KH char(10) not null
)
go
create table DatBao
(
MaKH char(4) references KH_Hang(MaKH),
Ma_Bao_TC char(4) references Bao_TChi(Ma_Bao_TC),
SoLuongMua int check (SoLuongMua>=0),
Ngay_DM datetime,
primary key (MaKH, Ma_Bao_TC)
)
-----Lệnh xem dữ liệu chứa trong bảng------
select * from Bao_TChi
select * from PhatHanh_Bao
select * from KH_Hang
select * from DatBao
----NHẬP DỮ LIỆU CHO CÁC BẢNG-------
--Nhập bảng Bao_TChi
insert into Bao_TChi values ('TT01', N'Tuổi trẻ', N'Nhật báo', 1000, 1500)
insert into Bao_TChi values ('KT01', N'Kiến thức ngày nay', N'Bán nguyệt san', 3000, 6000)
insert into Bao_TChi values ('TN01', N'Thanh niên', N'Nhật báo', 1000, 2000)
insert into Bao_TChi values ('PN01', N'Phụ nữ', N'Tuần báo', 2000, 4000)
insert into Bao_TChi values ('PN02', N'Phụ nữ', N'Nhật báo', 1000, 2000)
--Xem bảng Bao_TChi
select * from Bao_TChi
--Nhập bảng PhatHanh_Bao
set dateformat dmy
go
insert into PhatHanh_Bao values ('TT01', 123, '15/12/2005')
insert into PhatHanh_Bao values ('KT01', 70, '15/12/2005')
insert into PhatHanh_Bao values ('TT01', 124, '16/12/2005')
insert into PhatHanh_Bao values ('TN01', 256, '17/12/2005')
insert into PhatHanh_Bao values ('PN01', 45, '23/12/2005')
insert into PhatHanh_Bao values ('PN02', 111, '18/12/2005')
insert into PhatHanh_Bao values ('PN02', 112, '19/12/2005')
insert into PhatHanh_Bao values ('TT01', 125, '17/12/2005')
insert into PhatHanh_Bao values ('PN01', 46, '30/12/2005')
--Xem bảng PhatHanh_Bao
select * from PhatHanh_Bao
--Nhập bảng KH_Hang
insert into KH_Hang values ('KH01', N'LAN', '2 NCT')
insert into KH_Hang values ('KH02', N'NAM', '32 THD')
insert into KH_Hang values ('KH03', N'NGỌC', '16 LHP')
---Xem bảng KH_Hang
select * from KH_Hang
--Nhập bảng DatBao
set dateformat dmy
go
insert into DatBao values ('KH01', 'TT01', 100, '12/01/2000')
insert into DatBao values ('KH02', 'TN01', 150, '01/05/2001')
insert into DatBao values ('KH01', 'PN01', 200, '25/06/2001')
insert into DatBao values ('KH03', 'KT01', 50, '17/03/2002')
insert into DatBao values ('KH03', 'PN02', 200, '26/08/2003')
insert into DatBao values ('KH02', 'TT01', 250, '15/01/2004')
insert into DatBao values ('KH01', 'KT01', 300, '14/10/2004')
--Xem bảng DatBao
select * from DatBao
----TRUY VẤN DỮ LIỆU
--1. Cho biết các tờ báo, tạp chí (MaBaoTC, Ten, GiaBan) có định kỳ phát hành hàng tuần(Tuần báo)
select * from Bao_TChi
where DinhKy=N'Tuần báo'
--2. Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN)
select A.Ma_Bao_TC, A.Ten, A.DinhKy, B.So_Bao_TC, B.Ngay_PH, A.SoLuong, A.GiaBan
from Bao_TChi A, PhatHanh_Bao B
where A.Ma_Bao_TC = B.Ma_Bao_TC and A.Ma_Bao_TC like 'PN%'
--3. Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng
select A.MaKH, A.TenKH, A.DC_KH, B.Ma_Bao_TC, B.Ngay_DM, B.SoLuongMua
from KH_Hang A, DatBao B
where A.MaKH = B.MaKH and B.Ma_Bao_TC like 'PN%'
--4. Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN)
--5. Cho biết tên các khách hàng không đặt mua báo thanh niên
select A.MaKH, A.TenKH, A.DC_KH, B.Ma_Bao_TC, B.Ngay_DM, B.SoLuongMua
from KH_Hang A, DatBao B
where A.MaKH = B.MaKH and B.Ma_Bao_TC not like 'TN%'
--6. Cho biết số tờ báo mà mỗi khách hàng đã đặt mua
--7. Cho biết số khách hàng đặt mua báo trong năm 2004
select A.MaKH, A.TenKH, A.DC_KH, B.Ma_Bao_TC, B.Ngay_DM, B.SoLuongMua
from KH_Hang A, DatBao B
where A.MaKH = B.MaKH and YEAR(B.Ngay_DM) = 2004
--8. Cho biết thông tin đặt mua báo của khách hàng (TenKH, Ten, DinhKy, SL_Mua, SoTien), trong đó SoTien=SL_Mua*DonGia
select A.TenKH, B.Ten, B.DinhKy, C.SoLuongMua, C.SoLuongMua*B.GiaBan as SoTien
from KH_Hang A, Bao_TChi B, DatBao C
where A.MaKH = C.MaKH and B.Ma_Bao_TC = C.Ma_Bao_TC
--9. Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó
--a. Báo Tuổi trẻ
select A.Ma_Bao_TC, A.Ten, A.DinhKy, SUM(B.SoLuongMua) as TongSL_Mua
from Bao_TChi A, DatBao B
where A.Ma_Bao_TC = B.Ma_Bao_TC and A.Ten like N'Tuổi trẻ'
group by A.Ma_Bao_TC, A.Ten, A.DinhKy
--b. Báo Kiến thức ngày nay
select A.Ma_Bao_TC, A.Ten, A.DinhKy, SUM(B.SoLuongMua) as TongSL_Mua
from Bao_TChi A, DatBao B
where A.Ma_Bao_TC = B.Ma_Bao_TC and A.Ten like N'Kiến thức ngày nay'
group by A.Ma_Bao_TC, A.Ten, A.DinhKy
--c. Báo Thanh niên
select A.Ma_Bao_TC, A.Ten, A.DinhKy, SUM(B.SoLuongMua) as TongSL_Mua
from Bao_TChi A, DatBao B
where A.Ma_Bao_TC = B.Ma_Bao_TC and A.Ten like N'Thanh niên'
group by A.Ma_Bao_TC, A.Ten, A.DinhKy
--d. Báo Phụ nữ
select A.Ma_Bao_TC, A.Ten, A.DinhKy, SUM(B.SoLuongMua) as TongSL_Mua
from Bao_TChi A, DatBao B
where A.Ma_Bao_TC = B.Ma_Bao_TC and A.Ten like N'Phụ nữ'
group by A.Ma_Bao_TC, A.Ten, A.DinhKy
--10. Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS)

--11. Cho biết những tờ báo không có người đặt mua

--12. Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất

--13. Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất

--14. Cho biết các tờ báo phát hành định kỳ một tháng hai lần

--15. Cho biết các tờ báo, tạp chí có từ ba khách hàng đặt mua trở lên.

----THỦ TỤC VÀ HÀM
--I. Viết các hàm sau:
--1. Tính tổng số tiền mua báo/tạp chí của một khách hàng cho trước
--2. Tính tổng số tiền thu được của một tờ báo/tạp chí cho trước
--II. Viết các thủ tục sau:
--1. In danh mục báo, tạp chí phải giao cho một khách hàng cho trước
--2. In danh sách khách hàng đặt mua báo/tạp chí cho trước. 