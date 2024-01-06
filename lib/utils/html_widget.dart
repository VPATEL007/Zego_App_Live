import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialv/components/table_view_widget.dart';
import 'package:socialv/components/vimeo_embed_widget.dart';
import 'package:socialv/components/youtube_embed_widget.dart';
import 'package:socialv/screens/post/screens/image_screen.dart';
import 'package:socialv/screens/post/screens/pdf_screen.dart';
import 'package:socialv/screens/profile/screens/member_profile_screen.dart';
import 'package:socialv/utils/app_constants.dart';

class HtmlWidget extends StatelessWidget {
  final String? postContent;
  final Color? color;
  final double fontSize;

  HtmlWidget({this.postContent, this.color, this.fontSize = 14.0});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: postContent!,
      onLinkTap: (s, _, __, ___) {
        if (s!.split('/').last.contains('.pdf')) {
          PDFScreen(docURl: s).launch(context);
        } else {
          log(s);
          if (s.contains('?user_id=')) {
            MemberProfileScreen(memberId: s.splitAfter('?user_id=').toInt()).launch(context);
          } else {
            openWebPage(context, url: s);
          }
        }
      },
      onImageTap: (s, _, __, ___) {
        ImageScreen(imageURl: s.validate());
      },
      style: {
        "table": Style(backgroundColor: color ?? transparentColor, lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        "tr": Style(border: Border(bottom: BorderSide(color: Colors.black45.withOpacity(0.5))), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        "th": Style(padding: EdgeInsets.zero, backgroundColor: Colors.black45.withOpacity(0.5), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT)),
        "td": Style(padding: EdgeInsets.zero, alignment: Alignment.center, lineHeight: LineHeight(ARTICLE_LINE_HEIGHT)),
        'embed': Style(
            color: color ?? transparentColor,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: FontSize(fontSize),
            lineHeight: LineHeight(ARTICLE_LINE_HEIGHT),
            padding: EdgeInsets.zero),
        'strong': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'a': Style(
          color: color ?? context.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: FontSize(fontSize),
          lineHeight: LineHeight(ARTICLE_LINE_HEIGHT),
          padding: EdgeInsets.zero,
          textDecoration: TextDecoration.none,
        ),
        'div': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'figure': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), padding: EdgeInsets.zero, margin: EdgeInsets.zero, lineHeight: LineHeight(ARTICLE_LINE_HEIGHT)),
        'h1': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'h2': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'h3': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'h4': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'h5': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'h6': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'p': Style(
          color: color ?? textPrimaryColorGlobal,
          fontSize: FontSize(16),
          textAlign: TextAlign.justify,
          lineHeight: LineHeight(ARTICLE_LINE_HEIGHT),
          padding: EdgeInsets.zero,
        ),
        'ol': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'ul': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'strike': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'u': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'b': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'i': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'hr': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'header': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'code': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'data': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'body': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'big': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'blockquote': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), lineHeight: LineHeight(ARTICLE_LINE_HEIGHT), padding: EdgeInsets.zero),
        'audio': Style(color: color ?? textPrimaryColorGlobal, fontSize: FontSize(fontSize), padding: EdgeInsets.zero),
        'img': Style(width: context.width(), padding: EdgeInsets.only(bottom: 8), fontSize: FontSize(fontSize)),
        'li': Style(
          color: color ?? textPrimaryColorGlobal,
          fontSize: FontSize(fontSize),
          listStyleType: ListStyleType.DISC,
          listStylePosition: ListStylePosition.OUTSIDE,
        ),
      },
      customRender: {
        "embed": (RenderContext renderContext, Widget child) {
          var videoLink = renderContext.parser.htmlData.text.splitBetween('<embed>', '</embed');

          if (videoLink.contains('yout')) {
            return YouTubeEmbedWidget(videoLink.replaceAll('<br>', '').toYouTubeId());
          } else if (videoLink.contains('vimeo')) {
            return VimeoEmbedWidget(videoLink.replaceAll('<br>', ''));
          } else {
            return child;
          }
        },
        "figure": (RenderContext renderContext, Widget child) {
          if (renderContext.tree.element!.innerHtml.contains('yout')) {
            return YouTubeEmbedWidget(renderContext.tree.element!.innerHtml.splitBetween('<div class="wp-block-embed__wrapper">', "</div>").replaceAll('<br>', '').toYouTubeId());
          } else if (renderContext.tree.element!.innerHtml.contains('vimeo')) {
            return VimeoEmbedWidget(renderContext.tree.element!.innerHtml.splitBetween('<div class="wp-block-embed__wrapper">', "</div>").replaceAll('<br>', '').splitAfter('com/'));
          } else if (renderContext.tree.element!.innerHtml.contains('audio')) {
            //return AudioPostWidget(postString: renderContext.tree.element!.innerHtml);
          } else if (renderContext.tree.element!.innerHtml.contains('twitter')) {
            String t = renderContext.tree.element!.innerHtml.splitAfter('<div class="wp-block-embed__wrapper">').splitBefore('</div>');
            //return TweetWebView(tweetUrl: t);
          } else {
            return child;
          }
        },
        "iframe": (RenderContext renderContext, Widget child) {
          return YouTubeEmbedWidget(renderContext.tree.attributes['src']!.toYouTubeId());
        },
        "img": (RenderContext renderContext, Widget child) {
          String img = '';
          if (renderContext.tree.attributes.containsKey('src')) {
            img = renderContext.tree.attributes['src']!;
          } else if (renderContext.tree.attributes.containsKey('data-src')) {
            img = renderContext.tree.attributes['data-src']!;
          }
          if (img.isNotEmpty) {
            return CachedNetworkImage(
              imageUrl: img,
              width: context.width(),
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(commonRadius).onTap(() {
              ImageScreen(imageURl: img).launch(context);
            });
          } else {
            return Offstage();
          }
        },
        "blockquote": (RenderContext renderContext, Widget child) {
          // return TweetWebView(tweetUrl: renderContext.tree.element!.outerHtml);
        },
        "table": (RenderContext renderContext, Widget child) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.open_in_full_rounded),
                  onPressed: () async {
                    await TableViewWidget(renderContext).launch(context);
                    setOrientationPortrait();
                  },
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: (renderContext.tree as TableLayoutElement).toWidget(renderContext),
              ),
            ],
          );
        },
      },
    );
  }
}
