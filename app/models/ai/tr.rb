class Ai::Tr < ApplicationRecord

    def self.active_page
        locales = Spina.config.locales
        Spina::Page.live.order(:id).each do |page|
            next if page.id == 1
            p "#" * 66, page.id
            next if page.translations.count >= locales.size
            locales.each do |lang|
                p "=" * 55 + "translating #{lang}..."
                next if page.translations.find_by_locale(lang)
                t(page, lang)
                sleep(30)
            end
        end
    end

    def self.t(page, lang)
        title, content = title_and_content(page, lang)

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
        title = page.translations.where(locale: 'en').first.title
        title_prompt = "Translate the following text into #{lang}: #{title}"
        translated_title = translate(title_prompt)

        sleep(15)

        content = page.en_content.first.content
        content_prompt = "Translate the following text into #{lang}, Preserve decode html tag: #{content}"
        translated_content = translate(content_prompt)

        return translated_title, translated_content
    end

    def self.translate(prompt)
        p "-" * 33 + '>', prompt
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
        p "-" * 22 + '>'
        content = response['choices'][0]['text'].gsub("\n", '')
        p content
        content
    end
end
