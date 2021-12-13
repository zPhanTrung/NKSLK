namespace NKSLK.Entites
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CONGNHAN")]
    public partial class CONGNHAN
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CONGNHAN()
        {
            DANHSACHCONGNHANs = new HashSet<DANHSACHCONGNHAN>();
        }

        [Key]
        public int MaCN { get; set; }

        [StringLength(50)]
        public string HoTen { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgaySinh { get; set; }

        public bool? GioiTinh { get; set; }

        [StringLength(50)]
        public string PhongBan { get; set; }

        [StringLength(50)]
        public string ChucVu { get; set; }

        [StringLength(100)]
        public string QueQuan { get; set; }

        public decimal? LuongHopDong { get; set; }

        public decimal? LuongBaoHiem { get; set; }

        [StringLength(50)]
        public string TaiKhoan { get; set; }

        public virtual TAIKHOAN TAIKHOAN1 { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<DANHSACHCONGNHAN> DANHSACHCONGNHANs { get; set; }
    }
}
