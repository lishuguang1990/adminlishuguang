using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Utilities;

namespace BLL.MyHtmlHelper
{
    public static class CheckBoxListHelper1
    {
        public static MvcHtmlString CheckBoxList(this HtmlHelper htmlHelper, string name, IEnumerable<SelectListItem> listInfo, object htmlAttribute = null, Position position = Position.Horizontal, int number = 0, bool isTable = false)
        {
            IDictionary<string, object> htmlAttributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttribute);
            if (string.IsNullOrEmpty(name))
            {
                
                throw new ArgumentException("必须给CheckBoxList的name属性赋值", nameof(name));
            }
            if (listInfo == null)
            {
                throw new ArgumentNullException(nameof(listInfo), "List<SelectListItem> listInfo不能为null");
            }
            var selectListItems = listInfo as SelectListItem[] ?? listInfo.ToArray();
            if (!selectListItems.Any())
            {
                throw new ArgumentException("List<SelectListItem> listInfo至少要一组资料", nameof(listInfo));
            }

            var sb = new StringBuilder();
            var lineNumber = 0;
            switch (position)
            {
                case Position.Horizontal:
                    foreach (var info in selectListItems)
                    {
                        lineNumber++;
                        sb.Append(CreateCheckBoxItem(info, name, htmlAttributes, isTable));

                        if (number > 0 && (lineNumber % number == 0))
                        {
                            if (isTable)
                            {
                                sb = new StringBuilder("<tr>").Append(sb).Append(new StringBuilder("</tr>"));
                            }
                            else
                            {
                                sb.Append("<br />");
                            }
                        }
                    }
                    //sb.Append("<br />");
                    break;
                case Position.Vertical:
                    var dataCount = selectListItems.Length;
                    var rows = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(dataCount) / Convert.ToDecimal(number)));
                    if (dataCount <= number || dataCount - number == 1)
                    {
                        rows = dataCount;
                    }

                    var wrapBuilder = new TagBuilder("div");
                    wrapBuilder.MergeAttribute("style", "float:left; line-height:25px; padding-right:5px;");
                    var wrapStart = wrapBuilder.ToString(TagRenderMode.StartTag);
                    var wrapClose = string.Concat(wrapBuilder.ToString(TagRenderMode.EndTag), " <div style=\"clear:both;\"></div>");
                    var wrapBreak = string.Concat("</div>", wrapBuilder.ToString(TagRenderMode.StartTag));
                    sb.Append(wrapStart);

                    foreach (var info in selectListItems)
                    {
                        lineNumber++;
                        sb.Append(CreateCheckBoxItem(info, name, htmlAttributes, isTable));

                        if (lineNumber.Equals(rows))
                        {
                            sb.Append(wrapBreak);
                            lineNumber = 0;
                        }
                        else
                        {
                            sb.Append(wrapClose);
                        }
                    }
                    sb.Append(wrapClose);
                    break;
            }
            if (isTable)
            {
                sb = new StringBuilder("<tbody>").Append(sb).Append(new StringBuilder("</tbody>"));
                sb = new StringBuilder("<table class=\"CheckBox\" border=\"0\">").Append(sb).Append(new StringBuilder("</table>"));
            }
            return MvcHtmlString.Create(sb.ToString());
        }

        internal static string CreateCheckBoxItem(SelectListItem info, string name,
    IDictionary<string, object> htmlAttributes, bool isTable = false)
        {
            var sb = new StringBuilder();
            var builder = new TagBuilder("input");
            if (info.Selected)
            {
                builder.MergeAttribute("checked", "checked");
            }
            builder.MergeAttributes(htmlAttributes);
            builder.MergeAttribute("type", "checkbox");
            builder.MergeAttribute("value", info.Value);
            builder.MergeAttribute("name", name);
            builder.MergeAttribute("id", string.Format("{0}_{1}", name, info.Value));
            sb.Append(builder.ToString(TagRenderMode.Normal));

            var labelBuilder = new TagBuilder("label");
            labelBuilder.MergeAttribute("for", string.Format("{0}_{1}", name, info.Value));
            labelBuilder.InnerHtml = info.Text;
            sb.Append(labelBuilder.ToString(TagRenderMode.Normal));
            if (isTable)
            {
                sb = new StringBuilder("<td>").Append(sb).Append(new StringBuilder("</td>"));
            }
            return sb.ToString();
        }
    }
}
