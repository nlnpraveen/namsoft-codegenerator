using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace TrainingCompany.Controllers
{
    public class CacheExpireController : ApiController
    {
        public IEnumerable<CacheExpirationConfiguration> Get()
        {
            return cacheex;
        }
        /*public HttpResponseMessage Post([FromBody]course c)
        {
            c.id = courses.Count;
            courses.Add(c);
            //i should return a 201 with a location header
            var msg = Request.CreateResponse(
                HttpStatusCode.Created);
            msg.Headers.Location = 
                new Uri(Request.RequestUri + c.id.ToString());
            return msg;


        }
        public void Put(int id, [FromBody]course course)
        {
            var ret = (from c in courses
                       where c.id == id
                       select c).FirstOrDefault();
            ret.label = course.label;

          
        }
        public void Delete(int id)
        {
            var ret = (from c in courses
                       where c.id == id
                       select c).FirstOrDefault();
            courses.Remove(ret);
        }
        public HttpResponseMessage Get(int id)
        {
            HttpResponseMessage msg = null;
            var ret = (from c in courses
                       where c.id == id
                       select c).FirstOrDefault();
            //if null  - I should return a 404
            if (ret == null)
            {
                msg = Request.CreateErrorResponse(HttpStatusCode.NotFound, "Course not found!");

            }
            else
            {
                msg = Request.CreateResponse<course>(HttpStatusCode.OK, ret);
            }
            return msg;
        }
        public IEnumerable<course> Get(string term)
        {
            var ret = (from c in courses
                       where c.label.ToLower().Contains(term.ToLower())
                       select c);
            return ret;
        }*/

        static List<CacheExpirationConfiguration> cacheex = InitCache();

        private static List<CacheExpirationConfiguration> InitCache()
        {
            var ret = new List<CacheExpirationConfiguration>();
            ret.Add(new CacheExpirationConfiguration { Id = 1, CacheType = "Memcache", ClassName = "ParticipantManager", MethodName = "GetOrganizationIdByParticipantId" });
            ret.Add(new CacheExpirationConfiguration { Id = 2, CacheType = "HttpContextCache", ClassName = "ParticipantWorkflowManager", MethodName = "GetParticipantWorkflows" });
            return ret;
        }
    }
    public class CacheExpirationConfiguration
    {
        #region Private Members
        #endregion

        #region Public Properties

        private int _Id;
        /// <summary>
        /// Id. 
        /// </summary>
        public int Id
        {
            get { return _Id; }
            set { _Id = value; }
        }

        private string _ClassName;
        /// <summary>
        /// ClassName. 
        /// </summary>
        public string ClassName
        {
            get { return _ClassName; }
            set { _ClassName = value; }
        }

        private string _MethodName;
        /// <summary>
        /// MethodName. 
        /// </summary>
        public string MethodName
        {
            get { return _MethodName; }
            set { _MethodName = value; }
        }

        private string _CacheType;
        /// <summary>
        /// CacheType. 
        /// </summary>
        public string CacheType
        {
            get { return _CacheType; }
            set { _CacheType = value; }
        }

        private bool? _IsActive;
        /// <summary>
        /// IsActive. Default value has been set.
        /// </summary>
        public bool? IsActive
        {
            get { return _IsActive; }
            set { _IsActive = value; }
        }

        private DateTime? _CreateDate;
        /// <summary>
        /// CreateDate. Default value has been set.
        /// </summary>
        public DateTime? CreateDate
        {
            get { return _CreateDate; }
            set { _CreateDate = value; }
        }


        #endregion

        #region Constructors

        public CacheExpirationConfiguration()
        {
            bool _isActive; if (bool.TryParse("true", out _isActive)) IsActive = _isActive;
            CreateDate = DateTime.Now;
        }

        public CacheExpirationConfiguration(System.Data.DataRow row)
        {
            _Id = (row["Id"] == DBNull.Value) ? _Id : int.Parse(row["Id"].ToString());
            _ClassName = (row["ClassName"] == DBNull.Value) ? string.Empty : row["ClassName"].ToString();
            _MethodName = (row["MethodName"] == DBNull.Value) ? string.Empty : row["MethodName"].ToString();
            _CacheType = (row["CacheType"] == DBNull.Value) ? string.Empty : row["CacheType"].ToString();
            _IsActive = (row["IsActive"] == DBNull.Value) ? _IsActive : bool.Parse(row["IsActive"].ToString());
            _CreateDate = (row["CreateDate"] == DBNull.Value) ? _CreateDate : DateTime.Parse(row["CreateDate"].ToString());
        }

        #endregion

        #region Instance Methods
        #endregion
    }

}
