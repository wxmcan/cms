class Ai::Tr < ApplicationRecord

    def self.active_page
        locales = Spina.config.locales
        Spina::Page.live.each do |page|
            next if page.id == 1
            next if page.translations.count >= locales.size
            locales.each do |lang|
                p "=" * 55 + "in #{lang}..."
                next if page.translations.find_by_locale(lang)
                t(page, lang)
                sleep(30)
            end
        end
    end

    def self.t(page, lang)
        title, content = title_and_content(page, lang)
        p "-" * 33
        p title
        p content

        page.assign_attributes(
            "#{lang}_content":[{ type: "Spina::Parts::Text", name: "text", content: content }],
        )

        materialized_path = "/#{lang}#{page.materialized_path}"
        t = {locale: lang, title: title, materialized_path: materialized_path}
        page.translations.new(t)

        page.save
    end

    private
    def self.title_and_content(page, lang)
        p "*" * 44 + "in translate..."
        title = page.translations.where(locale: 'en').first.title
        p title_prompt = "Translate the following text into #{lang}: #{title}"
        content = page.en_content.first.content
        p content_prompt = "Translate the following text into #{lang}, Preserve Html Tag: #{content}"
        translated_title = translate(title_prompt)
        sleep(15)
        translated_content = translate(content_prompt)
        return translated_title, translated_content
    end

    def self.translate(prompt)
        # p "*" * 33
        client = OpenAI::Client.new(access_token: 'sk-xxx')
      
        response = client.completions(
          parameters:
          {
            prompt: prompt,
            model: "text-davinci-003",
            temperature: 0.9,
            # n: 8192,
            max_tokens: 2048
          }
        )
        p content = response['choices'][0]['text'].gsub("\n", '')
        content
    end
end
