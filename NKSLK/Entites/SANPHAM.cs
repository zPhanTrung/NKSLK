namespace NKSLK.Entites
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("SANPHAM")]
    public partial class SANPHAM
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SANPHAM()
        {
            CONGVIECDALAMs = new HashSet<CONGVIECDALAM>();
        }

        [Key]
        [StringLength(10)]
        public string MaSP { get; set; }

        [StringLength(100)]
        public string TenSP { get; set; }

        [StringLength(10)]
        public string SoDangKy { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayDangKy { get; set; }

        public int HanSuDung { get; set; }

        [StringLength(100)]
        public string QuyCach { get; set; }

        [Column(TypeName = "text")]
        public string Anh { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CONGVIECDALAM> CONGVIECDALAMs { get; set; }
    }
}
