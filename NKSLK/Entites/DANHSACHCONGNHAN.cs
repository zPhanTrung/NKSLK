namespace NKSLK.Entites
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("DANHSACHCONGNHAN")]
    public partial class DANHSACHCONGNHAN
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public DANHSACHCONGNHAN()
        {
            NKSLKs = new HashSet<NKSLK>();
        }

        [Key]
        public int MaDanhSach { get; set; }

        public int? MaTo { get; set; }

        public int? MaCN { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayThamGia { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayRoi { get; set; }

        public virtual CONGNHAN CONGNHAN { get; set; }

        public virtual TOCONGNHAN TOCONGNHAN { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<NKSLK> NKSLKs { get; set; }
    }
}
