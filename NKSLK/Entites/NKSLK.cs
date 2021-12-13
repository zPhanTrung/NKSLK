namespace NKSLK.Entites
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("NKSLK")]
    public partial class NKSLK
    {
        public int ID { get; set; }

        public int? MaDanhSach { get; set; }

        [Column(TypeName = "date")]
        public DateTime? NgayThucHien { get; set; }

        public TimeSpan? GioBatDau { get; set; }

        public TimeSpan? GioKetThuc { get; set; }

        public virtual DANHSACHCONGNHAN DANHSACHCONGNHAN { get; set; }
    }
}
