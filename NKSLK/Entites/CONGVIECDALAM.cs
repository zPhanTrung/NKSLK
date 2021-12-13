namespace NKSLK.Entites
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("CONGVIECDALAM")]
    public partial class CONGVIECDALAM
    {
        public int ID { get; set; }

        public int? MaCV { get; set; }

        [StringLength(10)]
        public string MaSP { get; set; }

        public int? SanLuong { get; set; }

        [StringLength(10)]
        public string SoLo { get; set; }

        public int? MaChiTietCaLam { get; set; }

        public virtual CHITIETCALAM CHITIETCALAM { get; set; }

        public virtual CONGVIEC CONGVIEC { get; set; }

        public virtual SANPHAM SANPHAM { get; set; }
    }
}
