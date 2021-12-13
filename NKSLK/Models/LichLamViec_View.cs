using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NKSLK.Models
{
    public class LichLamViec_View
    {
        public int? MaChiTietCaLam { get; set; }
        public int? MaTo { get; set; }
        public DateTime? NgayThucHien { get; set; }
        public int MaCa { get; set; }
        public string CaLamViec{ get; set; }
        public TimeSpan? GioBatDau { get; set; }
        public TimeSpan? GioKetThuc { get; set; }

    }
}