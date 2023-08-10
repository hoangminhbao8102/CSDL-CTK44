------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 04/03/2022
   Người thực hiện: Hoàng Nghĩa Minh Bảo
*/
------------------------------------------------
--Lệnh tạo CSDL
CREATE DATABASE Lab01_QuanLyNhanVien
go
--Lệnh sử dụng CSDL
use Lab01_QuanLyNhanVien
--Lệnh tạo các bảng
create table ChiNhanh
(MSCN	char(2) primary key, -- khai báo MSCN là khóa chính
TenCN	nvarchar(30) not null unique
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
NgaySinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN) -- khai báo MSCN là khóa ngoại tham chiếu đến khóa chính MSCN của quan hệ ChiNhanh 
)
go
create table KyNang
(MSKN	char(2) primary key,
TenKN	nvarchar(30) not null
)
go
create table NhanVienKyNang
(
MANV char(4) references NhanVien(MANV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=9)
primary key(MANV,MSKN) --khai báo khóa chính gồm nhiều thuộc tính
)
--Xem các bảng
select * from ChiNhanh
select * from NhanVien
select * from KyNang
select * from NhanVienKyNang
--Nhập dữ liệu cho các bản
--Nhập bảng ChiNhanh
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình thạnh')
--xem bảng ChiNhanh
select * from ChiNhanh
--Nhập bảng KyNang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--Xem bảng KyNang
select * from KyNang
--Nhập bảng NhanVien
set dateformat dmy --Khai báo định dạng ngày tháng 
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--Xem bảng NhanVien
select * from NhanVien
--Nhập bảng NhanVienKyNang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)
--Xem bảng NhanVienKyNang
select * from NhanVienKyNang
----------------TRUY VẤN DỮ LIỆU------------------------
--1. Truy vấn lựa chọn trên nhiều bảng
--a. Hiển thị MSNV, HoTen (Ho + Ten as HoTen), số năm làm việc (SoNamLamViec)
select MANV, Ho+' '+Ten As HoTen,YEAR(GETDATE())-YEAR(NgayVaoLam)as SoNamLamViec
from NhanVien
--b. Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp xếp theo tên chi nhánh)
select Ho+' '+Ten as HoTen, NgaySinh, NgayVaoLam, TenCN
from NhanVien A, ChiNhanh B
where	A.MSCN = B.MSCN
order by TenCN, Ten, Ho
--c. Liệt kê các nhân viên (HoTen, TenKN, MucDo) của những nhân viên biết sử dụng 'Word'
select Ho+' '+Ten as HoTen, TenKN, MucDo
from NhanVien A, NhanVienKyNang B,  KyNang C
where	A.MANV = B.MANV and B.MSKN = C.MSKN and TenKN = 'word'
--d. Liệt kê các kỹ năng (TenKN, MucDo) mà nhân viên 'Lê Anh Tuấn' biết sử dụng
select TenKN, MucDo
from NhanVien a, NhanVienKyNang b, KyNang c
where A.MANV = B.MANV and B.MSKN = C.MSKN and Ho = N'Lê Anh' and Ten = N'Tuấn'
--2. Truy vấn lồng
--a. Liệt kê MANV, HoTen, MSCN, TenCN của các nhân viên có mức độ thành thạo về 'Excel' cao nhất trong công ty
select	a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN, d.TenKN, c.MucDo
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and TenKN = 'excel' 
		and c.MucDo >=all (select e.MucDo
						from NhanVienKyNang e, KyNang f
						where e.MSKN= f.MSKN and f.TenKN = 'excel')
--b. Liệt kê MANV, HoTen, TenCN của các nhân viên vừa biết 'Word' vừa biết 'Excel' (dùng truy vấn lồng)
select b.MANV,Ho+' '+Ten as HoTen, TenCN
from ChiNhanh a, NhanVien b, NhanVienKyNang c, KyNang d
where a.MSCN = b.MSCN and b.MANV = c.MANV and c.MSKN = d.MSKN 
	  and TenKN = 'excel' 
	  and b.MANV IN (select e.MANV
					 from NhanVienKyNang e, KyNang f
					 where e.MSKN = f.MSKN and TenKN = 'word')
--c. Với từng kỹ năng, hãy liệt kê các thông tin (MANV, HoTen, TenCN, TenKN, MucDo) của những nhân viên thành thạo kỹ năng đó nhất
select	d.TenKN, a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN, c.MucDo
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and c.MucDo = (select MAX(e.MucDo)
						from NhanVienKyNang e
						where e.MSKN= d.MSKN)	
order by d.TenKN
--d. Liệt kê các chi nhánh (MSCN, TenCN) mà mọi nhân viên trong chi nhánh đó đều biết 'Word'
select	a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN, d.TenKN, c.MucDo
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and TenKN = 'Word'
--3. Truy vấn gom nhóm dữ liệu
--a. Với mỗi chi nhánh, hãy cho biết các thông tin sau TenCN, SoNV (số nhân viên của chi nhánh đó)
select	b.MSCN, TenCN, COUNT(MANV) as SoNV
from	NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by	b.MSCN, TenCN
--b. Với mỗi kỹ năng, hay cho biết TenKN, SoNguoiDung (số nhân viên biết sử dụng kỹ năng đó)
select	b.MSKN, TenKN, COUNT(MANV) as SoNguoiDung
from	NhanVienKyNang a, KyNang b
where a.MSKN = b.MSKN
group by	b.MSKN, TenKN
--c. Cho biết TenKN có từ 3 nhân viên trong công ty sử dụng trở lên
select	b.MSKN, TenKN, COUNT(MANV) as SoNguoiDung
from	NhanVienKyNang a, KyNang b
where a.MSKN = b.MSKN
group by	b.MSKN, TenKN
having COUNT(MANV)>=3
--d. Cho biết TenCN có nhiều nhân viên nhất.
select TenCN, count(MANV) as SoNV
from NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by TenCN
having	count(MANV)>=all (select COUNT(c.MANV)
							from NhanVien c
							group by c.MSCN)
--e. Cho biết TenCN có nhiều nhân viên nhất.
select TenCN, count(MANV) as SoNV
from NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by TenCN
having	count(MANV)<=all (select COUNT(c.MANV)
							from NhanVien c
							group by c.MSCN)
--f. Với mỗi nhân viên, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được
select		a.MANV, Ho+' '+Ten as HoTen, COUNT(MSKN) as SoKN
from		NhanVien a, NhanVienKyNang b
where		a.MANV = b.MANV
group by	a.MANV, Ho, Ten
having		COUNT(MSKN)>=3
order by	Ten, Ho
--g. Cho biết HoTen, TenCN của nhân viên biết sử dụng nhiều kỹ năng nhất
select	Ho+' '+Ten as HoTen,TenCN, COUNT(c.MSKN) as SoKN
from	NhanVien a, ChiNhanh b, NhanVienKyNang c
where	a.MSCN = b.MSCN and a.MANV = c.MANV
group by a.MANV, Ho, Ten, TenCN
having COUNT(c.mskn)>=all (select COUNT(d.MSKN)
							from NhanVienKyNang d
							group by d.MANV)
--4. Cập nhật dữ liệu
--a. Thêm bộ <'06', 'PhotoShop'> vào bảng KyNang
insert into KyNang values ('06', 'PhotoShop')
select * from KyNang
--b. Thêm các bộ sau vào bảng NhanVienKyNang: <'0001', '06', 3>; <'0005', '06', 2>
insert into NhanVienKyNang values ('0001', '06', 3)
insert into NhanVienKyNang values ('0005', '06', 2)
select * from NhanVienKyNang
--c. Cập nhật cao các nhân viên có sử dụng kỹ năng 'Word' có mức độ tăng thêm một bậc
update NhanVienKyNang
set MucDo = MucDo+1
where MSKN='01'
select * from NhanVienKyNang
--d. Tạo bảng mới NhanVienChiNhanh (MANV, HoTen, SoKyNang) (dùng lệnh Create table)
create table NhanVienChiNhanh
(MaNV char(4) primary key,
HoTen nvarchar(30),
SoKyNang	tinyint 
)
select * from NhanVienChiNhanh
--e. Thêm vào bảng trên các thông tin như đã liệt kê của các nhân viên thuộc chi nhánh (dùng câu lệnh Insert Into cho nhiều bộ)
insert into NhanVienChiNhanh(MaNV,HoTen, SoKyNang)
select		a.MANV, Ho+' '+Ten, COUNT(MSKN)
from		NhanVien a, NhanVienKyNang b
where		a.MANV = b.MANV and MSCN = '01'
group by	a.MANV, Ho, Ten
select * from NhanVienChiNhanh