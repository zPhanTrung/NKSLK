namespace NKSLK.Entites
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CHITIETCALAM")]
    public partial class CHITIETCALAM
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CHITIETCALAM()
        {
            CONGVIECDALAMs = new HashSet<CONGVIECDALAM>();
        }

        [Key]
        public int MaChiTietCaLam { get; set; }

        public int? MaTo { get; set; }

        public int? MaCa { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayThucHien { get; set; }

        public virtual CALAMVIEC CALAMVIEC { get; set; }

        public virtual TOCONGNHAN TOCONGNHAN { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CONGVIECDALAM> CONGVIECDALAMs { get; set; }
    }
}
