using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Utilities;

namespace DSF2.Services.MyHtmlHelper
{
    public static class RadioButtonListHelper
    {
        public static MvcHtmlString RadioButtonList(this HtmlHelper htmlHelper, string name, IEnumerable<SelectListItem> listInfo, object htmlAttribute = null, Position position = Position.Horizontal,
        int number = 0)
        {
            IDictionary<string, object> htmlAttributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttribute);
            if (string.IsNullOrEmpty(name))
            {
                throw new ArgumentException("必须给RadioButtonList的name属性赋值", nameof(name));
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
                        sb.Append(CreateRadioButtonItem(info, name, htmlAttributes));
                    }
                    sb.Append("<br />");
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
                        sb.Append(CreateRadioButtonItem(info, name, htmlAttributes));

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
            return MvcHtmlString.Create(sb.ToString());
        }

        internal static string CreateRadioButtonItem(SelectListItem info, string name, IDictionary<string, object> htmlAttributes)
        {
            var sb = new StringBuilder();
            var builder = new TagBuilder("input");
            if (info.Selected)
            {
                builder.MergeAttribute("checked", "checked");
            }
            builder.MergeAttributes(htmlAttributes);
            builder.MergeAttribute("type", "radio");
            builder.MergeAttribute("value", info.Value);
            builder.MergeAttribute("name", name);
            builder.MergeAttribute("id", string.Format("{0}_{1}", name, info.Value));
            sb.Append(builder.ToString(TagRenderMode.Normal));
            var labelBuilder = new TagBuilder("label");
            labelBuilder.MergeAttribute("for", string.Format("{0}_{1}", name, info.Value));
            labelBuilder.InnerHtml = info.Text;
            sb.Append(labelBuilder.ToString(TagRenderMode.Normal));
            return sb.ToString();
        }

    }
}
