using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NKSLK.Models
{
    public class NKSLK_View
    {
        public int MaNK { get; set; }
        public int? MaTo { get; set; }
        public int MaCN { get; set; }
        public string HoTen { get; set; }
        public DateTime? NgaySinh { get; set; }
        public bool? GioiTinh { get; set; }
        public DateTime? NgayThucHien { get; set; }
        public TimeSpan? GioBatDau { get; set; }
        public TimeSpan? GioKetThuc { get; set; }
    }
}