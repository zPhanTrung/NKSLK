using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace NKSLK.Entites
{
    public partial class QLNC : DbContext
    {
        public QLNC()
            : base("name=QLNC")
        {
        }

        public virtual DbSet<CALAMVIEC> CALAMVIECs { get; set; }
        public virtual DbSet<CHITIETCALAM> CHITIETCALAMs { get; set; }
        public virtual DbSet<CONGNHAN> CONGNHANs { get; set; }
        public virtual DbSet<CONGVIEC> CONGVIECs { get; set; }
        public virtual DbSet<CONGVIECDALAM> CONGVIECDALAMs { get; set; }
        public virtual DbSet<DANHSACHCONGNHAN> DANHSACHCONGNHANs { get; set; }
        public virtual DbSet<NKSLK> NKSLKs { get; set; }
        public virtual DbSet<SANPHAM> SANPHAMs { get; set; }
        public virtual DbSet<TAIKHOAN> TAIKHOANs { get; set; }
        public virtual DbSet<TOCONGNHAN> TOCONGNHANs { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CONGNHAN>()
                .Property(e => e.LuongHopDong)
                .HasPrecision(8, 0);

            modelBuilder.Entity<CONGNHAN>()
                .Property(e => e.LuongBaoHiem)
                .HasPrecision(8, 0);

            modelBuilder.Entity<CONGVIEC>()
                .Property(e => e.DinhMucKhoan)
                .HasPrecision(4, 2);

            modelBuilder.Entity<CONGVIEC>()
                .Property(e => e.HeSoKhoan)
                .HasPrecision(4, 2);

            modelBuilder.Entity<CONGVIEC>()
                .Property(e => e.DinhMucLaoDong)
                .HasPrecision(4, 2);

            modelBuilder.Entity<CONGVIEC>()
                .Property(e => e.DonGia)
                .HasPrecision(8, 0);

            modelBuilder.Entity<CONGVIECDALAM>()
                .Property(e => e.MaSP)
                .IsUnicode(false);

            modelBuilder.Entity<CONGVIECDALAM>()
                .Property(e => e.SoLo)
                .IsUnicode(false);

            modelBuilder.Entity<SANPHAM>()
                .Property(e => e.MaSP)
                .IsUnicode(false);

            modelBuilder.Entity<SANPHAM>()
                .Property(e => e.SoDangKy)
                .IsUnicode(false);

            modelBuilder.Entity<SANPHAM>()
                .Property(e => e.Anh)
                .IsUnicode(false);

            modelBuilder.Entity<TAIKHOAN>()
                .Property(e => e.TaiKhoan1)
                .IsUnicode(false);

            modelBuilder.Entity<TAIKHOAN>()
                .Property(e => e.MatKhau)
                .IsUnicode(false);

            modelBuilder.Entity<TAIKHOAN>()
                .Property(e => e.VaiTro)
                .IsUnicode(false);


        }
    }
}
