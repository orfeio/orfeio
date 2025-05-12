---
title: Video in PDFs
layout: default 
---

# Video in PDFs

[Do not embed video in PDFs](https://www.overleaf.com/learn/latex/Questions/How_can_I_embed_a_video_in_my_PDF_using_LaTeX%3F).

[Link](https://www.overleaf.com/learn/latex/Hyperlinks) to the video files or hosted versions instead.

## A Problematic Workaround

If you must embed a video into a PDF document, do not attempt to implement it in the original LaTeX.

Instead, create placeholder slides within the LaTeX, then [use Adobe Acrobat to insert the video media](https://helpx.adobe.com/acrobat/using/rich-media.html).

**Do not** expect the PDF to render properly, if at all, on untested devices that lack a current version of Acrobat.

### Example Embedded Video Placeholder Slide

{% raw %}
```
\documentclass{beamer}
% Theme can be changed or removed for a cleaner look
\usetheme{default}
\begin{document}
\begin{frame}[plain] % 'plain' removes header/footer
\vfill
\begin{center}
\fbox{%
\begin{minipage}[c][0.6\textheight][c]{0.8\textwidth}
\centering
\Large Insert Video Here
\end{minipage}%
}
\end{center}
\vfill
\end{frame}
\end{document}
```
{% endraw %}
