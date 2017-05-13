<template lang="pug">
  article
    h1 diff
    .btn-group
      button.btn.btn-default(@click="markdown") Markdown
      button.btn.btn-default(@click="preview") Preview
      button.btn.btn-default(@click="diff") Preview Diff
    .section
      .editor.html(v-if="isMarkdown")
        textarea.form-control(v-model="newMarkdown")
      .editor.preview(v-if="isPreview")
        .preview-area.markdown-body(v-html="previewHTML")
      .editor.preview-diff(v-if="isDiff")
        .preview-area.markdown-body(v-html="diffHTML")
</template>

<script>
  import { component } from '../libs/bus';

  module.exports = {
    mixins: [component],
    data () {
      return {
        isMarkdown: true,
        isPreview: false,
        isDiff: false,
        newMarkdown: '# new markdown\n\nこれは古いmerkdown です',
        oldMarkdown: '# old markdown\n\nこれは古いmerkdown です',
        previewHTML: 'pre',
        diffHTML: 'diff',
      };
    },
    methods: {
      switchDisplay (mode) {
        this.isMarkdown = false;
        this.isPreview = false;
        this.isDiff = false;

        this[mode] = true;
      },
      markdown () {
        this.switchDisplay('isMarkdown');
      },
      preview () {
        this.switchDisplay('isPreview');

        this.api.createMarkdown({ body: { markdown: this.newMarkdown } })
          .then(({ html }) => this.previewHTML = html);
      },
      diff () {
        this.switchDisplay('isDiff');

        this.api.createDiff({ body: { a: this.oldMarkdown, b: this.newMarkdown } })
          .then(({ html }) => this.diffHTML = html);
      },
    },
  };
</script>
