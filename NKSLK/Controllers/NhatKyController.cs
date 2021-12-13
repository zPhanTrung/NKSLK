using NKSLK.Dao;
using NKSLK.Entites;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NKSLK.Controllers
{
    public class NhatKyController : Controller
    {
        QLNC db = new QLNC();

        public ActionResult Index(FormCollection collection, int Page = 1)
        {
            ViewBag.CaLamViec = db.CALAMVIECs.ToList();
            ViewBag.MaCN = collection["macn-search"];
            ViewBag.HoTen = collection["hoten-search"];
            ViewBag.MaTo = collection["mato-search"];
            ViewBag.MaCa = collection["maca-search"];
            ViewBag.NgayBatDau = collection["ngaybatdau-search"];
            ViewBag.NgayKetThuc = collection["ngayketthuc-search"];
            var nhatky = NhatKyDao.Search(collection, db);
            int lenght = nhatky.ToList().Count;
            if (lenght % 10 > 0)
                ViewBag.PageNumber = lenght / 10 + 1;
            else
                ViewBag.PageNumber = lenght / 10;
            ViewBag.CurrentPage = Page;
            var model = nhatky.ToList().Skip((Page - 1) * 10);
            model = model.Take(10);
            return View(model.ToList());
        }

        public ActionResult HienThiDiemDanh(FormCollection collection, int Page = 1)
        {
            ViewBag.MaTo = collection["mato-diemdanh"];
            ViewBag.NgayThucHien = collection["ngaythuchien-diemdanh"];
            ViewBag.CaLamViec = null;
            ViewBag.DuocCheckIn = null;
            ViewBag.DuocCheckOut = null;

            var dateNow = DateTime.Today;
            var timeNow = DateTime.Now.TimeOfDay;
            ViewBag.x = dateNow;

            var nhatky = NhatKyDao.HienThiDiemDanh(collection, db);
            if(nhatky.Count>0)
            {
                try
                {
                    var mato = int.Parse(collection["mato-diemdanh"]);
                    var ngaythuchien = DateTime.Parse(collection["ngaythuchien-diemdanh"]);
                    var ctCaLam = db.CHITIETCALAMs.Where(s => s.MaTo == mato && s.NgayThucHien == ngaythuchien).FirstOrDefault();
                    var calam = db.CALAMVIECs.Find(ctCaLam.MaCa);
                    ViewBag.CaLamViec = calam.TenCa;

                    TimeSpan? giobatdau = calam.GioBatDau;
                    TimeSpan? gioketthuc = calam.GioKetThuc;
                    TimeSpan t1 = giobatdau.Value.Add(new TimeSpan(0, 0, -10, 0));
                    TimeSpan t2 = gioketthuc.Value.Add(new TimeSpan(0, -1, 0, 0));
                    if (dateNow == ngaythuchien)
                    {
                        if (timeNow >= t1 && timeNow <= t2)
                        {
                            ViewBag.DuocCheckIn = true;
                        }
                        else if (timeNow >= t2)
                            ViewBag.DuocCheckIn = null;
                        else if (timeNow <= t1)
                            ViewBag.DuocCheckIn = false;

                        if (timeNow >= giobatdau && timeNow <= gioketthuc)
                            ViewBag.DuocCheckOut = true;
                        else
                            ViewBag.DuocCheckOut = false;
                    }   
                }
                catch { }
            }
            int lenght = nhatky.ToList().Count;
            if (lenght % 10 > 0)
                ViewBag.PageNumber = lenght / 10 + 1;
            else
                ViewBag.PageNumber = lenght / 10;
            ViewBag.CurrentPage = Page;
            var model = nhatky.ToList().Skip((Page - 1) * 10);
            model = model.Take(10);
            return View(model.ToList());
        }

        public ActionResult CheckIn(FormCollection collection)
        {
            var id = int.Parse(collection["id"]);
            var giobatdau = collection["giobatdau"];
            var time = TimeSpan.Parse(giobatdau);
            string rs = Newtonsoft.Json.JsonConvert.SerializeObject(time);
            var nk = db.NKSLKs.Find(id);
            if (nk != null)
            {
                nk.GioBatDau = time;
                db.SaveChanges();
            }
            return Json(rs, JsonRequestBehavior.AllowGet);
        }

        public ActionResult CheckOut(FormCollection collection)
        {
            var id = int.Parse(collection["id"]);
            var gioketthuc = collection["gioketthuc"];
            var time = TimeSpan.Parse(gioketthuc);
            string rs = Newtonsoft.Json.JsonConvert.SerializeObject(time);
            var nk = db.NKSLKs.Find(id);
            if (nk != null)
            {
                nk.GioKetThuc = time;
                db.SaveChanges();
            }
            return Json(rs, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}