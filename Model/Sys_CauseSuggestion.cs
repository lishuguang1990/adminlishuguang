using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("CauseId")]
    public  class Sys_CauseSuggestion
    {
         public int CauseId { get; set; }

        public string CauseContent { get; set; }

        public int ParentId { get; set; }

        public string Code { get; set; }

        public int Sort { get; set; }

        public int CauseLevel { get; set; }

        public string CauseCode { get; set; }

        public string SuggestionContent { get; set; }

        public string RelatedContent { get; set; }

        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }
    }
}
