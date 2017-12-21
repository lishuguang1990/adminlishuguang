using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Web.Routing;

namespace com.zh.kj.MallWeiXin.BizLogic
{
   public static class HtmltHelper
    {
        /// <summary>
        /// 扩展radiobutton 列表
        /// </summary>
        /// <typeparam name="TModel">实体</typeparam>
        /// <typeparam name="TValue">属性</typeparam>
        /// <param name="helper"></param>
        /// <param name="expression">表达式</param>
        /// <param name="items">数据列表</param>
        /// <param name="column">每行显示个数</param>
        /// <param name="attributes">html属性</param>
        /// <returns></returns>
        public static MvcHtmlString RadioButtonListFor<TModel, TValue>(this  HtmlHelper<TModel> helper, Expression<Func<TModel, TValue>> expression, IEnumerable<SelectListItem> items, int column = 0, object attributes = null)
        {
            string raidobuttonStr = "";
            BuildListTag(out raidobuttonStr, "radio", items, expression, column, attributes);
            return MvcHtmlString.Create(raidobuttonStr);
        }

        /// <summary>
        /// 扩展radiobutton 列表
        /// </summary>
        /// <typeparam name="TModel">实体</typeparam>
        /// <typeparam name="TValue">属性</typeparam>
        /// <param name="helper"></param>
        /// <param name="expression">表达式</param>
        /// <param name="viewDataName">viewData数据列表名称</param>
        /// <param name="column">每行显示个数</param>
        /// <param name="attributes">属性</param>
        /// <returns></returns>
        public static MvcHtmlString RadioButtonListFor<TModel, TValue>(this  HtmlHelper<TModel> helper, Expression<Func<TModel, TValue>> expression, string viewDataName, int column = 0, object attributes = null)
        {
            string raidobuttonStr = "";
            var items = helper.ViewData[viewDataName] as List<SelectListItem>;
            BuildListTag(out raidobuttonStr, "radio", items, expression, column, attributes);
            return MvcHtmlString.Create(raidobuttonStr);
        }


        /// <summary>
        /// 扩展radiobutton 列表
        /// </summary>
        /// <typeparam name="TModel">实体</typeparam>
        /// <typeparam name="TValue">属性</typeparam>
        /// <param name="helper"></param>
        /// <param name="expression">表达式</param>
        /// <param name="items">数据列表</param>
        /// <param name="column">每行显示个数</param>
        /// <param name="attributes">html属性</param>
        /// <returns></returns>
        public static MvcHtmlString CheckBoxListFor<TModel, TValue>(this  HtmlHelper<TModel> helper, Expression<Func<TModel, TValue>> expression, IEnumerable<SelectListItem> items, int column = 0, object attributes = null)
        {
            string raidobuttonStr = "";
            BuildListTag(out raidobuttonStr, "checkbox", items, expression, column, attributes);
            return MvcHtmlString.Create(raidobuttonStr);
        }

        /// <summary>
        /// 扩展radiobutton 列表
        /// </summary>
        /// <typeparam name="TModel">实体</typeparam>
        /// <typeparam name="TValue">属性</typeparam>
        /// <param name="helper"></param>
        /// <param name="expression">表达式</param>
        /// <param name="viewDataName">viewData数据列表名称</param>
        /// <param name="column">每行显示个数</param>
        /// <param name="attributes">属性</param>
        /// <returns></returns>
        public static MvcHtmlString CheckBoxListFor<TModel, TValue>(this  HtmlHelper<TModel> helper, Expression<Func<TModel, TValue>> expression, string viewDataName, int column = 0, object attributes = null)
        {
            string raidobuttonStr = "";
            var items = helper.ViewData[viewDataName] as List<SelectListItem>;
            BuildListTag(out raidobuttonStr, "checkbox", items, expression, column, attributes);
            return MvcHtmlString.Create(raidobuttonStr);
        }

        /// <summary>
        /// 构造radioList或者checkBoxList标签
        /// </summary>
        /// <typeparam name="TModel"></typeparam>
        /// <typeparam name="TValue"></typeparam>
        /// <param name="raidobuttonStr">拼接的字符窜</param>
        /// <param name="tag">标签(checkbox or  radio)</param>
        /// <param name="expression">表达式</param>
        /// <param name="items">数据列表</param>
        /// <param name="column">每行显示个数</param>
        /// <param name="attributes">属性</param>
        private static void BuildListTag<TModel, TValue>(out  string raidobuttonStr, string tag, IEnumerable<SelectListItem> items, Expression<Func<TModel, TValue>> expression, int column = 0, object attributes = null)
        {
            raidobuttonStr = "";
            if (items != null && items.Any())
            {
                int count = 1;
                ///获取表达式属性名称
                var name = (expression.Body as MemberExpression).Member.Name;
                foreach (var item in items)
                {
                    TagBuilder raidobutton = new TagBuilder("input");
                    raidobutton.Attributes.Add("type", tag);
                    raidobutton.Attributes.Add("name", name);
                    raidobutton.Attributes.Add("value", item.Value);
                    if (item.Selected)
                    {
                        raidobutton.Attributes.Add("checked", "checked");
                    }
                    if (attributes != null)
                    {
                        raidobutton.MergeAttributes(new RouteValueDictionary(attributes));
                    }

                    raidobuttonStr += raidobutton.ToString(TagRenderMode.SelfClosing);
                    raidobuttonStr +="<span>"+item.Text+"</span>";
                  //  raidobuttonStr += "&nbsp;&nbsp;&nbsp;";

                    if (column == 1)
                    {
                        raidobuttonStr += "<br/>";
                    }
                    ///根据每行显示个数设置换行
                    else
                    {
                        if (count == column && column != 0)
                        {
                            raidobuttonStr += "<br/>";
                        }
                    }
                    count++;
                }

            }



        }
    }
}
