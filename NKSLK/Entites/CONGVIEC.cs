namespace NKSLK.Entites
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CONGVIEC")]
    public partial class CONGVIEC
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CONGVIEC()
        {
            CONGVIECDALAMs = new HashSet<CONGVIECDALAM>();
        }

        [Key]
        public int MaCV { get; set; }

        [StringLength(30)]
        public string TenCV { get; set; }

        public decimal DinhMucKhoan { get; set; }

        [StringLength(15)]
        public string DonViKhoan { get; set; }

        public decimal HeSoKhoan { get; set; }

        public decimal DinhMucLaoDong { get; set; }

        public decimal DonGia { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CONGVIECDALAM> CONGVIECDALAMs { get; set; }
    }
}
