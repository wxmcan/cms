# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://guides.defi.io"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  coins = Coin.limit(4000)
  coins.each do |coin|
    add "/how-to-buy-#{coin.symbol}", :lastmod => coin.updated_at
  end

  coins = Coin.limit(500)
  coins.each do |coin|
    add "/how-to-add-#{coin.symbol}-to-metamask", :lastmod => coin.updated_at
  end
  
  pages = Spina::Page.live
  pages.each do |page|
    translations = page.translations
      translations.each do |p|
        add p.materialized_path, :lastmod => p.updated_at
      end
  end

end
