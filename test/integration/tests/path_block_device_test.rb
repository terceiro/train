# encoding: utf-8

describe "file interface" do
  let(:backend) { get_backend.call }

  describe "block device" do
    let(:file) { backend.file("/tmp/block_device") }

    it "exists" do
      _(file.exist?).must_equal(true)
    end

    it "is a block device" do
      _(file.block_device?).must_equal(true)
    end

    it "has type :block_device" do
      _(file.type).must_equal(:block_device)
    end

    it "has no content" do
      _(file.content).must_equal("")
    end

    it "has owner name root" do
      _(file.owner).must_equal("root")
    end

    it "has group name" do
      _(file.group).must_equal(Test.root_group(backend.os))
    end

    it "has mode 0666" do
      _(file.mode).must_equal(00666)
    end

    it "checks mode? 0666" do
      _(file.mode?(00666)).must_equal(true)
    end

    it "has no link_path" do
      _(file.link_path).must_be_nil
    end

    it "has the correct md5sum" do
      _(file.md5sum).must_equal("d41d8cd98f00b204e9800998ecf8427e")
    end

    it "has the correct sha256sum" do
      _(file.sha256sum).must_equal("e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
    end

    it "has a modified time" do
      _(file.mtime).must_be_close_to(Time.now.to_i - Test.mtime / 2, Test.mtime)
    end

    it "has inode size of 0" do
      _(file.size).must_equal(0)
    end

    it "has selinux label handling" do
      res = Test.selinux_label(backend, file.path)
      _(file.selinux_label).must_equal(res)
    end

    it "has no product_version" do
      _(file.product_version).must_be_nil
    end

    it "has no file_version" do
      _(file.file_version).must_be_nil
    end
  end
end
