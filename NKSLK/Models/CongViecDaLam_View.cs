using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NKSLK.Models
{
    public class CongViecDaLam_View
    {
        public int MaCVDaLam { get; set; }
        public int? MaCV { get; set; }
        public string TenCV { get; set; }
        public string MaSP { get; set; }
        public string TenSP { get; set; }
        public int? SanLuong { get; set; }
        public string SoLo { get; set; }
    }
}